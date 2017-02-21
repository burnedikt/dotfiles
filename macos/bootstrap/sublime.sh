SUBLIMEPATH=~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
DOTFILESROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../.. && pwd )"
CONFIGPATH=$DOTFILESROOT/sublime/Packages/User
# remove current user directory
rm -r $SUBLIMEPATH
# link the synchronized sublime folder
symlink $CONFIGPATH $SUBLIMEPATH
