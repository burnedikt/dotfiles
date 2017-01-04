$install_script_path="$PSScriptRoot\install\windows\install.ps1"
. "$install_script_path"
# basic installation is done, everything else will take place in babun
$user_folder=$env:USERPROFILE
$cygpath_path="$user_folder\.babun\cygwin\bin\cygpath.exe"
if (Test-Path "$cygpath_path") {
  # run cygpath to find the cygwin path to the dotfiles repo on your machine
  $cygwin_dotfiles_path= & "$cygpath_path" $PSScriptRoot
  Write-Output ""
  Write-Output ""
  Write-Warning "Please execute the following command in babun (!!) to finish the installation"
  Write-Output "===================================="
  Write-Output ""
  Write-Output "cd $cygwin_dotfiles_path && . ./install.sh"
  Write-Output ""
  Write-Output "===================================="
  Write-Output ""
  Write-Output ""
} else {
  Write-Error "Missing Cygpath application to convert paths from windows to cygwin"
}
