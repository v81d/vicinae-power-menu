#!/bin/bash

SOCKET="${SOCKET_PATH:-$HOME/.local/share/vicinae-power-menu/helper.sock}"
mkdir -p "$(dirname "$SOCKET")"

# Create FIFO if missing or replace non-FIFO
if [[ -e "$SOCKET" && ! -p "$SOCKET" ]]; then
    rm -f "$SOCKET"
fi
[[ ! -p "$SOCKET" ]] && mkfifo "$SOCKET"

DE=${XDG_CURRENT_DESKTOP:-unknown}

declare -A COMMANDS
case "$DE" in
    Hyprland|HYPRLAND)
        COMMANDS[lock]="hyprlock"
        COMMANDS[logout]="hyprctl dispatch exit"
        ;;
    Sway|SWAY)
        COMMANDS[lock]="swaylock"
        COMMANDS[logout]="swaymsg exit"
        ;;
    GNOME)
        COMMANDS[lock]="gnome-screensaver-command -l"
        COMMANDS[logout]="gnome-session-quit --logout --no-prompt"
        ;;
    KDE|PLASMA)
        COMMANDS[lock]="qdbus org.freedesktop.ScreenSaver /ScreenSaver Lock"
        COMMANDS[logout]="qdbus org.kde.ksmserver /KSMServer logout 0 0 0"
        ;;
    *)
        COMMANDS[lock]="loginctl lock-session"
        COMMANDS[logout]="loginctl terminate-user $USER"
        ;;
esac

COMMANDS[suspend]="systemctl suspend"
COMMANDS[reboot]="systemctl reboot"
COMMANDS[poweroff]="systemctl poweroff"

# Open FIFO
exec 3<>"$SOCKET"

# Drain pre-existing writes
while read -t 0.01 -r _ <&3; do :; done

# Main loop
while true; do
    if read -r cmd <&3; then
        if [[ -n "${COMMANDS[$cmd]}" ]]; then
            eval "${COMMANDS[$cmd]}"
        else
            echo "Unknown command: $cmd"
        fi
    fi
done
