# If there are any password protected keys in ~/.ssh
# on first shell login you will be asked for their pw's.
# You can then use them in any session without being asked for pw.

# Other options here:
# https://unix.stackexchange.com/questions/90853/how-can-i-run-ssh-add-automatically-without-password-prompt

#  exit ssh-agent on fish shell logout
# Nvm bc im pretty sure on any shell exit it will cause subsequent attempts to fail.
# if [ -n "$SSH_AUTH_SOCK" ] ; then
#   eval `/usr/bin/ssh-agent -k`
# fi
# But might want it for ssh sessions.


setenv SSH_ENV $HOME/.ssh/environment

function start_agent
	echo "Initializing new SSH agent ..."
  ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
  echo "succeeded"
  chmod 600 $SSH_ENV
  source $SSH_ENV > /dev/null
  ssh-add
end

function test_identities
	ssh-add -l | grep "The agent has no identities" > /dev/null
  if [ $status -eq 0 ]
    ssh-add
    if [ $status -eq 2 ]
      start_agent
    end
  end
end

if [ -n "$SSH_AGENT_PID" ]
  ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
  if [ $status -eq 0 ]
    test_identities
  end
else
	if [ -f $SSH_ENV ]
	  source $SSH_ENV > /dev/null
	end
	ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
	if [ $status -eq 0 ]
	  test_identities
	else
	  start_agent
	end
end
