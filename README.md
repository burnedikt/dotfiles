# burnedikt's dotfiles

## Disclaimer

These dotfiles work for me. That doesn't neccessarily mean they also work for you.
For starters, they are specific to MacOS and Windows (10 upwards).

If you're not running MacOS (El Capitan or higher) or Windows 10, these dotfiles will not just work for you.

## Installation

For handling these dotfiles, we'll use GNU Stow which will also be installed automatically, if you run the install script.

### macOS

To take the quick route, just run `chmod +x ./bootstrap && ./bootstrap` to get everything setup.

### Windows

On Windows, fire up an **elevated Powershell** (run as admin), change your directory (`cd`) to the dotfiles folder and run the following command (this will disable the ExecutionPolicy while running the boostrap script):

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; .\bootstrap.ps1
```

After the pre-requisites (git-bash, ...) have been installed, open up babun / git bash and
cd into the dotfiles folder. Here, just run `. ./bootstrap` to proceed with the default installation as on UNIX systems.

### Manual Labor

#### macOS

##### Sublime Text Icon

The [sublime text icon](sublime/icon.icns) (all thanks goes to [Yannik Siebert](https://dribbble.com/shots/1827488-Final-Sublime-Text-Replacement-Icon)) needs to be assigned to sublime manually. Instructons on how to change an application's icon can be found [here](http://www.macworld.co.uk/how-to/mac-software/how-change-os-x-yosemites-icons-3597494/).
