# check if brew is installed already, if it isn't prompt the user to do so
res=`which brew &>/dev/null`
if [[ $? != 0 ]]; then
  echo 'Installing Homebrew...'
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew update
fi
# install packages now
brew bundle
