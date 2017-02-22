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
  $title = "Windows Console Emulator Choice"
  $message = "Do you want to use Git for Windows (Git Bash) or Babun (cygwin)?"

  $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Git Bash", `
      "Git Bash based on MSYS is a very stripped down bash focused entirely on working with git."

  $no = New-Object System.Management.Automation.Host.ChoiceDescription "&Cygwin", `
      "Linux-like environment for Windows making it possible to port software running on POSIX systems (such as Linux, BSD, and Unix systems) to Windows"

  $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

  $result = $host.ui.PromptForChoice($title, $message, $options, 0)

  switch ($result)
  {
      0 {
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
      }
      1 {
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
      }
  }
} else {
  Write-Warning "This Script required Admin privileges. Please run your PowerShell as Admin!"
}
