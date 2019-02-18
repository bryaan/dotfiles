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


################################################
# Startup Items
################################################

# TODO running this causes an annoying enter pw every terminal start, even though its only in one window.
# So only run it when you need it.  Or better yet there is a way to let ssh config use mac keychain.
#
# When first shell of session starts we start ssh-agent.
# Only one shell gets this message.
#
# if not [ -e /tmp/brydots.ssh_agent.lock ]
#   touch /tmp/brydots.ssh_agent.lock
#   ssh_agent_start
#   rm /tmp/brydots.ssh_agent.lock
# end

setenv SSH_ENV $HOME/.ssh/environment

function __start_agent
	echo "Initializing new SSH agent ..."
  ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
  echo "succeeded"
  chmod 600 $SSH_ENV
  source $SSH_ENV > /dev/null
  ssh-add
end

function __test_identities
	ssh-add -l | grep "The agent has no identities" > /dev/null
  if [ $status -eq 0 ]
    ssh-add
    if [ $status -eq 2 ]
      __start_agent
    end
  end
end

function ssh_agent_start
  if [ -n "$SSH_AGENT_PID" ]
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
      __test_identities
    end
  else
  	if [ -f $SSH_ENV ]
  	  source $SSH_ENV > /dev/null
  	end
  	ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
  	if [ $status -eq 0 ]
  	  __test_identities
  	else
  	  __start_agent
  	end
  end
end
