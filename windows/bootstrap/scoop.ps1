# scoop installer script as described here:
# https://github.com/lukesampson/scoop#installation
# first check if scoop is already installed
$scoop=Get-Command scoop
if (!$?) {
  Write-Warning "Scoop not found. Installing..."
  Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}
# git is required to install other packages
scoop install "git-with-ssh"

# register additional buckets
$scoopBuckets = @("nerd-fonts", "extras")
ForEach( $bucket in $scoopBuckets ) {
  scoop bucket add $bucket
}

# now that scoop has been installed, install all the required packages
$scoops = @("starship", "FiraCode", "windows-terminal", "ruby", "python", "nvm", "curl", "gnupg", "go")
ForEach( $scoop in $scoops ) {
  scoop install $scoop
}

# ... and we can proceed with the installation there
Write-Output "Scoop and packages installation finished. Everything else can now be done from within git bash."
