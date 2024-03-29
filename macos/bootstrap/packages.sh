# check if brew is installed already, if it isn't prompt the user to do so
res=`which brew &>/dev/null`
if [[ $? != 0 ]]; then
  echo 'Installing Homebrew...'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew update
fi
# path to the brewfile
BREWFILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# install packages now
brew bundle --verbose --file=$BREWFILE_DIR/Brewfile
