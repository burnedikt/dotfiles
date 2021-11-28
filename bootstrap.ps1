function Dos2Unix {
  param([string]$dospath)
  return $dospath -replace '\\','/' -replace '^([A-Z]+):/','/$1/'
}

if (([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544") {
  # the above line ensures we're running as admin

  # try to install scoop + packages
  $scoop_install_script_path = "$PSScriptRoot\windows\bootstrap\scoop.ps1"
  . "$scoop_install_script_path"
  Write-Output "Successfully checked Scoop installation"

  # try to install chocolatey + packages
  $chocolatey_install_script_path = "$PSScriptRoot\windows\bootstrap\choco.ps1"
  . "$chocolatey_install_script_path"
  Write-Output "Successfully checked Chocolatey installation"

  # Enable WSL2 support
  dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

  # start git-bash / mysis (if installed)
  $bash_path = "$env:userprofile\scoop\apps\git\current\bin\sh.exe"
  $dotfiles_bootstrap_path = "$PSScriptRoot\bootstrap"
  Write-Output "Now running bootstrap script in bash..."
  if (Test-Path $bash_path) {
    & $bash_path --login $dotfiles_bootstrap_path
    Write-Output "Bootstrap script run successfully"
    Write-Output "Opening Git-Bash for you ..."
    # afterwards, start git-bash / mysis will automatically open
    $git_bash_path = "$env:userprofile\scoop\apps\git\current\git-bash.exe"
    & $git_bash_path
  } else {
    Write-Error "Git-Bash has apparently not been installed correctly. Please check"
  }
} else {
  Write-Warning "This Script required Admin privileges. Please run your PowerShell as Admin!"
}
