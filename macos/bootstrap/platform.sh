
function set_osx_defaults() {
    user "$(printf "Do you wish to install sensible defaults for OSX (this might take some time)?
    (%bY/y%b)es, (%bN/n%b)o?" \
    $light_yellow $reset_color \
    $light_yellow $reset_color)"

    local set_defaults=false
    while true; do
        # Read from tty, needed because we read in outer loop.
        read -n 1 action < /dev/tty

        case "$action" in
            y) set_defaults=true; break;;
            Y) set_defaults=true; break;;
            n) set_defaults=false; break;;
            N) set_defaults=false; break;;
            *) ;;
        esac
    done

    if $set_defaults ; then
        info "$(printf "Tweaking %b%s%b default settings. Please enter your %b%s%b:" $light_green "macos" $reset_color $light_green "password" $reset_color)"
        OSX_DEFAULTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
        source "$OSX_DEFAULTS_DIR/osx-defaults.sh"
        success "$(printf "Successfully tweaked %b%s%b default settings." $light_green "macos" $reset_color)"
    else
        info "$(printf "Not tweaking %b%s%b default settings" $light_green "macos" $reset_color)"
    fi
}

set_osx_defaults
