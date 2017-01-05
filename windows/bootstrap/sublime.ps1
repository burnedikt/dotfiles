# see https://packagecontrol.io/docs/syncing#dropbox
cd "$env:appdata\Sublime Text 3\Packages\"
rmdir -recurse User
cmd /c mklink /D User $env:userprofile\Dropbox\Sublime\User
