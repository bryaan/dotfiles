Open an Admin Powershell

cmd /c mklink /D $env:HOME\Documents\WindowsPowerShell $env:HOME\src\dotfiles\os_windows\WindowsPowerShell


Also need to symlink the
$DOTFILEs/languages/julia/config ~/.julia/config