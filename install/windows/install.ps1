# chocolatey installer script as described here:
# https://chocolatey.org/install
# NEEDS TO BE RUN AS ADMIN!!!
# first check if chocolatey is already installed
$choco=Get-Command choco
if (!$?) {
  Write-Warning "Choco not found. Installing..."
  Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression
}
# now that chocolatey has been installed, install all the required stuff
# i.e. babun
$chocos = Get-Content "$PSScriptRoot\Chocofile"
ForEach( $choco in $chocos ) {
  choco install -y $choco
}
# afterwards, babun will automatically open
# ... and we can proceed with the installation there
Write-Output "Chocolatey and Babun installation finished. Everything else can now be done from within babun / cygwin."
# leave
exit
