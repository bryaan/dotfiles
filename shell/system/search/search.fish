################################################
# ag, rg, find - Search Files & Directories
################################################

# Set colors to match ag.
# 2 Lines above and below matches,
# max char count of any line 300 chars.
function rg
  command rg \
    # --colors line:fg:yellow      \
    # --colors line:style:bold     \
    # --colors path:fg:green       \
    # --colors path:style:bold     \
    # --colors match:fg:black      \
    # --colors match:bg:yellow     \
    # --colors match:style:nobold  \
    -A 2  -B 2  --max-columns 300 --pretty \
    $argv
end

################################################
# Search Commands
################################################

# rg - Uses Rust Regex Format
# https://doc.rust-lang.org/regex/regex/index.html#syntax
#
# --debug   Gives detailed search AST and more
# -i        Ignore case
#
# Examples:
# search front

function search
  rg -i $argv
end

alias search.files='search.files.fuzzy'

function search.files.regex
  rg -i $argv
end

function search.files.fuzzy
  # so we use rg to grab all files from pwd down
  # then give that to skim where you can fuzzy search
  rg --files --follow --glob '!.git/*' --glob '!Library/' | sk
end

# Show match counts only
function search.countonly
  rg -i --count $argv
end


# Searching file contents
# with ag - respects .agignore and .gitignore
# try this with peco
# ag --nobreak --nonumbers --noheading . | fzf

# TODO https://github.com/peco/peco
# peco can be a great tool to filter stuff like logs, process stats, find files, because unlike grep, you can type as you think and look through the current result

