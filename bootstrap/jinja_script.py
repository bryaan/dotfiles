#!/usr/bin/env python3
import os
import socket
import shutil
import pathlib
from sys import platform
from jinja2 import Environment, FileSystemLoader, select_autoescape

# Can modify these if needed.
# They are all relative to project root.

# Where shell templates are located.
SHELL_FILES_DIR="shell"

# Where built templates go
BUILD_DIR="build/"

##########################################################################

def info(msg):
  print("\r  [ \033[00;34mℹ\033[0m ] " + msg)

def user(msg):
  print("\r  [ \033[0;33m??\033[0m ] " + msg)

def success(msg):
  print("\r\033[00;34m  [ \033[0m✔\033[00;34m ] \033[0m" + msg)

def fail(msg):
  print("\r\033[2K  [\033[0;31mFAIL\033[0m]" + msg)


######################################
# Compiling
######################################

# Note: no leading slashes in subsequent args.
# If this file's location changes the `..` arg must be as well.
PROJECT_ROOT = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..')
PROJECT_ROOT = os.path.normpath(PROJECT_ROOT) # Resolves `..`
# This allows this script to be called from anypath and still find shell path correctly.
SHELL_FILES_DIR = os.path.join(PROJECT_ROOT , SHELL_FILES_DIR)
# Path to output build files to.
BUILD_DIR = os.path.join(PROJECT_ROOT, BUILD_DIR)

def merge_dicts(*dict_args):
    """
    Given any number of dicts, shallow copy and merge into a new dict,
    precedence goes to key value pairs in latter dicts.
    """
    result = {}
    for dictionary in dict_args:
        result.update(dictionary)
    return result

def create_env():
  # Create the jinja2 environment.
  # Notice the use of trim_blocks, which greatly helps control whitespace.
  env = Environment(
    loader = FileSystemLoader([ PROJECT_ROOT ]),
    trim_blocks = True
    # autoescape = select_autoescape(['html', 'xml'])
  )
  return env

def clean_target():
  shutil.rmtree(BUILD_DIR, ignore_errors=True)
  os.makedirs(BUILD_DIR, exist_ok=True)

def get_env_vars():
  env_dict = {}
  # 'geo': {'work': ''},
  # 'os': {'linux': '', 'mac': ''},
  # 'shell': {'fish': '', 'zsh': ''}

  # Geolocation
  if 'nclmiami.ncl.com' in socket.gethostname():
    # IsWork='true'
    env_dict.update({ 'geo': {'work': 'true'} })
  else:
    env_dict.update({ 'geo': {} })

  # Operating System
  if platform == "linux" or platform == "linux2":
    env_dict.update({ 'os': {'linux': 'true'} })
  elif platform == "darwin":
    env_dict.update({ 'os': {'mac': 'true'} })

  return env_dict

# Get the basedirectory of a a path relative to PROJECT_ROOT
def project_rel_basedir(filepath):
  basepath = str(filepath).replace(filepath.name, '')
  return Path(basepath).relative_to(PROJECT_ROOT)
#
def compile(filepath, env_dict):
  # > You don't need to addon the other shells and setthem to false, but if you do
  # > it's not `false` but empty string you need to use ''.
  shell_fish = {'shell': {'fish': 'true'}}
  # shell_zsh = {'shell': {'zsh': 'true'}}

  # Create merged dict for each shell.
  fish_env_dict = merge_dicts(env_dict, shell_fish)
  # zsh_env_dict = merge_dicts(env_dict, shell_zsh)

  # Setup template.
  env = create_env()
  reltplpath = filepath.relative_to(PROJECT_ROOT)
  tpl = env.get_template(str(reltplpath))

  # Make parent build directories.
  build_parent = BUILD_DIR + str(project_rel_basedir(filepath))
  Path(build_parent).mkdir(parents=True, exist_ok=True)

  # Compile for fish.
  relfilepath = str(reltplpath).replace('.tpl', '.fish')
  relfilepath = Path(BUILD_DIR).joinpath(relfilepath)
  tpl.stream(fish_env_dict).dump(str(relfilepath))

  # Compile for zsh.
  # relfilepath = str(reltplpath).replace('.tpl', '.zsh')
  # relfilepath = Path(BUILD_DIR).joinpath(relfilepath)
  # tpl.stream(zsh_env_dict).dump(filepath)

######################################
# Installing
######################################

import os.path
from os.path import expanduser, basename
from shutil import move
import re
from pathlib import Path

HOME_DIR = Path(expanduser("~"))

# Finds all project files with *.symlink and
# links them in the user's $HOME.
def install_dotfiles():
  files = Path(PROJECT_ROOT).glob('**/*.symlink')
  for src in files:
    # Rename file. Ex: zshrc.symlink -> .zshrc
    fname = str(src.name) # get file name only
    fname = '.' + re.sub('\.symlink$', '', fname)
    dst = HOME_DIR.joinpath(fname)

    pretty_dst = str(dst)
    pretty_src = re.sub(PROJECT_ROOT + '/', '', str(src))

    # Symlink and checks.
    # Is a symlink already present resolving to same src file?
    if dst.exists() and str(dst.resolve()) == str(src):
      success('skipped ' + pretty_src)
    else:
      # Backup check
      # Check if $dst already exists and is not a symlink.
      if dst.exists() and not dst.is_symlink():
        # We have some regular file here, back it up.
        dst.rename(str(dst) + '.backup')
        success('moved ' + pretty_dst + ' to ' + pretty_dst + '.backup')
      elif dst.is_symlink():
        # We have some other symlink here. Remove it.
        dst.unlink()
        success('deleted symlink: ' + pretty_dst)

      # Symlink to $HOME
      dst.symlink_to(src)
      success('linked ' + pretty_src + ' to ' + pretty_dst)

######################################
# Main Process
######################################

# print('PROJECT_ROOT', PROJECT_ROOT)
# print('SHELL_FILES_DIR', SHELL_FILES_DIR)
# print('BUILD_DIR', BUILD_DIR)

env_dict = get_env_vars()

import json
import pprint

info('Template Variables:')
# info(str(env_dict))
# info(json.dumps(env_dict, indent=1))
info(pprint.pformat(env_dict, width=1))

# Clean target
clean_target()

# Compile Templates
files = Path(PROJECT_ROOT).glob('**/*.tpl')
for src in files:
  compile(src, env_dict)

# Install Dotfiles
install_dotfiles()
