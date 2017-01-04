[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
# get list of all installed fonts
$objFonts = New-Object System.Drawing.Text.InstalledFontCollection
$fonts=$objFonts.Families
# check if meslo font is installed
if ($fonts -contains "Meslo LG S for Powerline") {
  Write-Warning "Powerline fonts already installed. If you're still missing some, try to install manually"
  exit 0
} else {
  Write-Output "Powerline fonts not yet installed"
  exit 1
}
