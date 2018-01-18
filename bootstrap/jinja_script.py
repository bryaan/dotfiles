#!/usr/bin/env python3
import os
import socket
import shutil
import pathlib
from sys import platform
from jinja2 import Environment, FileSystemLoader, select_autoescape

# Can modify these if needed.
# They are all relative to project root.
BUILD_DIR="build/shell/"
SHELL_FILES_DIR="shell"

##########################################################################

######################################
# Functions
######################################

# Note: no leading slashes in subsequent args.
# If this file's location changes the `..` arg must be as well.
PROJECT_ROOT = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..')
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
	  loader = FileSystemLoader([ SHELL_FILES_DIR ]),
	  trim_blocks = True
	  # autoescape = select_autoescape(['html', 'xml'])
	)
	return env

def compile(filename, env_dict):
	# > You don't need to addon the other shells and setthem to false, but if you do
	# > it's not `false` but empty string you need to use ''.
	shell_fish = {'shell': {'fish': 'true'}}
	shell_zsh = {'shell': {'zsh': 'true'}}

	# Create merged dict for each shell.
	fish_env_dict = merge_dicts(env_dict, shell_fish) #{**env_dict, **shell_fish}
	zsh_env_dict = merge_dicts(env_dict, shell_zsh)


	# Compile one for fish and zsh each.
	env = create_env()
	tpl = env.get_template(filename)
	tpl.stream(fish_env_dict).dump(
		os.path.join(BUILD_DIR, filename.replace('.tpl', '.fish')))
	tpl.stream(zsh_env_dict).dump(
		os.path.join(BUILD_DIR, filename.replace('.tpl', '.zsh')))

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


######################################
# Main Process
######################################

env_dict = get_env_vars()

print('  [ ℹ ] Template Variables:')
print('  [ ℹ ] ', env_dict)

# Clean target
clean_target()

# Compile Templates
compile('index.tpl', env_dict)
compile('base.tpl', env_dict)
compile('dev.tpl', env_dict)
compile('git.tpl', env_dict)
compile('ncl.tpl', env_dict)
