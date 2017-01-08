# see https://packagecontrol.io/docs/syncing#dropbox
cd "$env:appdata\Sublime Text 3\Packages\"
# build path to dotfiles repo's Sublime User Package
$sublime_path = resolve-path $PSScriptRoot\..\..\sublime\Packages\User | select -ExpandProperty Path
cmd /c "rmdir User & mklink /D User $sublime_path"
