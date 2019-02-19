Set-Alias r Reload-PowerShell  -Option AllScope
Set-Alias reload Reload-PowerShell

Set-Alias c clear

#--------------------------------------------
# PATH
#--------------------------------------------

# TODO This should go in another file and come first.

# Add PowerShell scripts to PATH
$ProfileRoot = (Split-Path -Parent $MyInvocation.MyCommand.Path)
$env:Path += ";$ProfileRoot/scripts"

# msbuild [VS Build Tools]
# $env:Path += ";C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin"

# nuget (yes it comes with VS but can't find to place on path so downloaded instead)
# $env:Path += ";C:\Bryan\src\tools\nuget"

# dxc and fxc shader compilers
# $env:Path += ";C:\Program Files (x86)\Windows Kits\10\bin\10.0.17134.0\x64"

# Julia 1.0.0
# $env:Path += ";C:\Julia\Julia-1.0.0\bin"

#--------------------------------------------
# Setup Env Vars/Func   
#--------------------------------------------

# To list all env vars (show the Env drive)
function show-env-vars { Get-ChildItem :Env }

$env:src = "C:\Users\Bryan\src"
function src { cd $env:src }

$env:TibraRoot = "C:\Users\Bryan\src\tibra"

#-------------------------------------------- 
# oh-my-posh settings  
#--------------------------------------------
 
Import-Module posh-git
Import-Module oh-my-posh
Set-Theme agnoster

# Font in use: https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/M/complete/Meslo%20LG%20M%20Regular%20Nerd%20Font%20Complete%20Windows%20Compatible.otf
# Actually it is this: https://github.com/powerline/fonts/blob/master/Meslo%20Slashed/Meslo%20LG%20M%20Regular%20for%20Powerline.ttf
# And this for VSCode: 

$ThemeSettings.MyThemesLocation = "~\Documents\WindowsPowerShell\PoshThemes"
$ThemeSettings.Colors.WithBackgroundColor = 'black'

# Hide your git username@domain when not in a virtual machine.
$DefaultUser = 'bryaan'

#--------------------------------------------
# Extra                 
#--------------------------------------------

# Dotnet CLI Opt-Out
$env:DOTNET_CLI_TELEMETRY_OPTOUT = 1



