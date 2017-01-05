echo "Do you wish to install sensible defaults for OSX (this might take some time)?"
  select yn in "Yes" "No"; do
      case $yn in
          Yes ) echo 'Tweaking OS X...'; source "$(pwd)/osx-defaults.sh" break;;
          No ) echo 'Not tweaking OS X. Just re-run install.sh if you change your mind'; break;;
      esac
  done
