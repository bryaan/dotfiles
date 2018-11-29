####################################################
# http
####################################################

# TODO lookup # CPU on system and replace 4
abbr -a axel 'axel -n 4'

# Resume downloads by default
abbr -a wget 'wget -c $argv'


# get web server headers
function header
  curl -I $argv
end

# find out if remote server supports gzip / mod_deflate or not #
function header.supports.compression
  curl -I --compress $argv
end
