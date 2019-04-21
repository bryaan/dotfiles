# # Works on Mac and Linux
# function command_exists {
#   # this should be a very portable way of checking if something is on the path
#   # usage: "if command_exists foo; then echo it exists; fi"
#   type "$1" &> /dev/null
# }
#
function command_exists
  command -v $1 >/dev/null
  # Also there is:
  # type --quiet xxx, TODO what is diff? can check for both here?
end
