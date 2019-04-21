# Source file if it exists.
function source_if_exists
  set -l file $argv
  if test -e $file
    source $file
  end
end
