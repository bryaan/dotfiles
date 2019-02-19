scoop install openssh
scoop install git vim
scoop install python

pip3 install --upgrade pip
pip3 install jupyter

# Install oh-my-posh
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser

# Link global .gitconfig
New-Item -ItemType SymbolicLink -Name .gitconfig -Target ~\Documents\WindowsPowerShell\dotfiles\.gitconfig
