# check if brew is installed already, if it isn't prompt the user to do so
# If we on OS X, install homebrew and tweak system a bit.
# find out which platform we're running on
_platform=`platform`
if [[ "$_platform" == 'macos' ]]; then
  res=`which -s brew`
  if [[ $? != 0 ]]; then
    echo 'Installing Homebrew...'
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      brew update
  fi
elif [[ "$_platform" == 'cygwin' ]]; then
  res=`which -s choco`
  if [[ $? != 0 ]]; then
    echo 'You need to install Chocolatey Package Manager first. Please refer to the readme and run install.ps1 in an elevated Powershell before running the install.sh script'
    exit 1
  fi
fi
