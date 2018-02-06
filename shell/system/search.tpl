################################################
# ag, rg, find - Search Files & Directories
################################################

# Make rg'scolors look like ag's
# alias rg='rg --colors line:fg:yellow --colors line:style:bold --colors path:fg:green --colors path:style:bold --colors match:fg:black --colors match:bg:yellow --colors match:style:nobold'

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
  rg.base -i $argv
end

# Show match counts only
function search.countonly
  rg.base -i --count $argv
end

# Set colors to match ag.
# 2 Lines above and below matches,
# max char count of any line 300 chars.
function rg.base
  rg --colors line:fg:yellow      \
     --colors line:style:bold     \
     --colors path:fg:green       \
     --colors path:style:bold     \
     --colors match:fg:black      \
     --colors match:bg:yellow     \
     --colors match:style:nobold  \
     -A 2  -B 2  --max-columns 300 --pretty \
     $argv
end



# Searching file contents
# with ag - respects .agignore and .gitignore
# try this with peco
# ag --nobreak --nonumbers --noheading . | fzf

# TODO https://github.com/peco/peco
# peco can be a great tool to filter stuff like logs, process stats, find files, because unlike grep, you can type as you think and look through the current result

