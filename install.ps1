$install_script_path="$PSScriptRoot\windows\install.ps1"
. "$install_script_path"
# basic installation is done, everything else will take place in msys
# convert path to project from windows to posix
$dotfiles_project_path = $PSScriptRoot.ToLower() -replace '\\','/' -replace '(.*):/','/$1/'
Write-Output ""
Write-Output ""
Write-Warning "Please execute the following command in git-bash (!!) to finish the installation"
Write-Output "===================================="
Write-Output ""
Write-Output "cd $dotfiles_project_path  && . ./install.sh"
Write-Output ""
Write-Output "===================================="
Write-Output ""
Write-Output ""
