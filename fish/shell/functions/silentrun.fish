# Note this is using sh, may need to be bash/fish depending on use.
function silentrun
  sh -c 'nohup "(echo $argv)" &>/dev/null 2>&1 &'
end
