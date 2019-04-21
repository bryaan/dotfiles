

function ssh.classified --description='Log into remote server'
  ssh -t bryan@classified "export TERM=iterm2; fish"
end


# TODO where to move to? ssh.fish?

function fssh -d "Fuzzy-find ssh host and ssh into it"
  ag '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2 | fzf | xargs -o ssh
end

function fs -d "Switch tmux session"
  tmux list-sessions -F "#{session_name}" | fzf | xargs tmux switch-client -t
end
