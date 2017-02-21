function Dos2Unix {
  param([string]$dospath)

  return $dospath -replace '\\','/' -replace '^([A-Z]+):/','/$1/'
}

if (([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544") {
  # the above line ensures we're running as admin
  # try to install chocolatey
  $chocolatey_install_script_path = "$PSScriptRoot\cygwin\bootstrap\choco.ps1"
  #. "$chocolatey_install_script_path"
  Write-Output "Successfully checked Chocolatey installation"
  # try to install babun
  $babun_install_script_path = "$PSScriptRoot\cygwin\bootstrap\babun.ps1"
  . "$babun_install_script_path"
  Write-Output "Successfully checked Babun installation"
  Write-Output "Windows specific bootstrap script run successfully"
  # basic installation is done, everything else will take place in babun
  & babun.bat
  Write-Output "Please enter the following command in Babun to complete dotfiles setup..."
  # get the (unix) path to the dotfiles folder
  $dotfiles_folder_unix = Dos2Unix "$PSScriptRoot"
  Write-Output "

=======================================================================
"
  Write-Output "~ cd $dotfiles_folder_unix"
  Write-Output "~ chmod +x ./bootstrap && . ./bootstrap"
  Write-Output "
=======================================================================

"
} else {
  Write-Warning "This Script required Admin privileges. Please run your PowerShell as Admin!"
}
