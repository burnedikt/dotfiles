echo "Updating Sublime Text 3 Configuration"
# find out which platform we're running on
_platform=`platform`
if [[ "$_platform" == 'macos' ]]; then
  SUBLIMEPATH=~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
  CONFIGPATH=$(pwd)/sublime/Packages/User
  FILES="$CONFIGPATH/*.sublime-settings"
  for file in $FILES
  do
    filename=$(basename "$file")
    # take action on each file. $f store current file name
    # check whether the file already exists in the sublime text folder.
    if [ -L "$SUBLIMEPATH/$filename" ]; then
      # if it is a symlink, overwrite it
      echo "Symlink to config file $filename already exists. Overwriting ..."
    elif [ -f "$SUBLIMEPATH/$filename" ]; then
      # if it is a file, back it up
      echo "Config File $filename already exists. Backing up ..."
      cp "$SUBLIMEPATH/$filename" "$SUBLIMEPATH/$filename.bak"
    fi
    # now replace the file / symlink with a symlink into our repo
    ln -sf "$file" "$SUBLIMEPATH"
  done
else
  echo 'Synchronizing sublime settings only works for macOS as of now'
fi
