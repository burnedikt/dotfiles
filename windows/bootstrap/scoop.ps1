# scoop installer script as described here:
# https://github.com/lukesampson/scoop#installation
# first check if scoop is already installed
$scoop=Get-Command scoop
if (!$?) {
  Write-Warning "Scoop not found. Installing..."
  Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}
# now that scoop has been installed, install all the required packages
scoop install starship
scoop bucket add nerd-fonts
scoop install FiraCode

# ... and we can proceed with the installation there
Write-Output "Scoop and packages installation finished. Everything else can now be done from within git bash."
# leave
exit