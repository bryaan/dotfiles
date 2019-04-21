
# Checks that the path exists before adding it.
function append_path
  set -l dir $argv
  set -x PATH $PATH $dir
  # TODO as workaround can check if path is already on before appending.
end