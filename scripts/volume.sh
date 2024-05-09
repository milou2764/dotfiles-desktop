#!/usr/bin/env sh

send_notification() {
    volume=$(amixer -c 0 get Master | grep -Po "Playback \K\d\d")
    if [ "${volume}" -gt 70 ]; then icon=notification-audio-volume-high
    elif [ "${volume}" -gt 40 ]; then icon=notification-audio-volume-medium
    elif [ "${volume}" -gt 0 ]; then icon=notification-audio-volume-low
    else icon=notification-audio-volume-muted
    fi
    # dunstify -a "changevolume" -u low -r "9993" -h int:value:"$volume" -i "$icon" "Volume: ${volume}%" -t 2000
    canberra-gtk-play -i audio-volume-change -d "changeVolume" &
}

show_usage() {
    echo "Usage: $(basename "$0") [up|down|mute]" >&2
    echo "  up         Increase volume by 5%"
    echo "  down       Decrease volume by 5%"
    echo "  mute       Toggle mute/unmute"
}

case $1 in
up)
    # Set the volume on (if it was muted)
    amixer -qc 0 set Master 2dB+
    send_notification "$1"
    exit 0
    ;;
down)
    amixer -qc 0 set Master 2dB-
    send_notification "$1"
    exit 0
    ;;
mute)
    pamixer -t
    if eval "$(pamixer --get-mute)"; then
        dunstify -i notification-audio-volume-muted -a "changevolume" -t 2000 -r 9993 -u low "Muted"
    else
        send_notification up
    fi
    exit 0
    ;;
*)
    show_usage
    exit 1
    ;;
esac

