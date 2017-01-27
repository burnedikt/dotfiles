if (([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544") {
  # the above line ensures we're running as admin
  $install_script_path="$PSScriptRoot\windows\choco.ps1"
  . "$install_script_path"
  # basic installation is done, everything else will take place in msys
  Write-Output "Successfully checked Chocolatey installation"
  # start git-bash / mysis (if installed)
  $bash_path = "$env:programfiles\Git\bin\sh.exe"
  $dotfiles_bootstrap_path = "$PSScriptRoot\bootstrap"
  Write-Output "Now running bootstrap script in bash..."
  if (Test-Path $bash_path) {
    & $bash_path --login $dotfiles_bootstrap_path
    Write-Output "Bootstrap script run successfully"
    Write-Output "Opening Git-Bash for you ..."
    # afterwards, start git-bash / mysis will automatically open
    $git_bash_path = "$env:programfiles\Git\git-bash.exe"
    & $git_bash_path
  } else {
    Write-Error "Git-Bash has apparently not been installed correctly. Please check"
  }
} else {
  Write-Warning "This Script required Admin privileges. Please run your PowerShell as Admin!"
}
