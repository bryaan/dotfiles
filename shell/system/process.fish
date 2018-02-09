################################################
# ps - Process Status
################################################

# Usage: pid.info <pid>
abbr -a pid.info 'ps -Flww -p'

# TODO https://github.com/lotabout/skim/issues/78
# fuzzy kill processes
function fkill -d 'fuzzy kill processes'
  ps -ef | sed 1d | sk --multi | awk '{print $2}' | xargs echo
end
