#!/usr/bin/env bash

# Just a dirty script for lemonbar,
# you need to use 'siji' font for icons.

# main monitor

monitor=${1:-0}
height=25

hlpad=25
padding_top=0
padding_bottom=8
padding_left=5
padding_right=${padding_left}
bottom=0
top=$height+$padding_top
geometry=( $(herbstclient monitor_rect $monitor) )
# geometry has the format: X Y W H
	x="${geometry[0]}"
	y="${geometry[1]}"
	width="${geometry[2]}"
((bottom))
# padding
printf '%dx%d%+d%+d' $width $height $x $y
function uniq_linebuffered() {
    exec awk '$0 != l { print ; l=$0 ; fflush(); }' "$@"
}

herbstclient pad $monitor $hlpad
# settings
RES="x16xx"
FONT="-*-fixed-medium-*-*-*-12-*-*-*-*-*-*-*"
FONT2="-*-envy-code-r-*-*-6-*-*-*-*-*-*-*"
FONT3="-*-envy-code-r-*-*-6-*-*-*-*-*-*-*"

BG="#202421"
FG="#fffffa"
BLK="#262626"
RED="#d70000"
YLW="#d75f00"
BLU="#45536E"
GRA="#898989"
VLT="#7B3D93"

# icons
st="%{F$YLW}  %{F-}"
sm="%{F$RED}  %{F-}"
sv="%{F$BLU}  %{F-}"
sd="%{F$VLT}  %{F-}"

source ~/.config/lemonbar/music
# functions

set -f

function uniq_linebuffered() {
    awk -W interactive '$0 != l { print ; l=$0 ; fflush(); }' "$@"
}

# events
{
    # now playing
    mpc idleloop player | cat &
    mpc_pid=$!

    while true; do
	    echo "bat $(acpi -b | awk '{gsub(/%,/,""); print $4}' | sed 's/%//g') $(acpi -b | awk '{gsub(/,/,""); print $3}')"
	    sleep 1 || break
    done > >(uniq_linebuffered) &
    bat_pid=$!


    # volume
    while true ; do
        echo "vol $(amixer get Master | tail -1 | sed 's/.*\[\([0-9]*%\)\].*/\1/')"
	sleep 1 || break
    done > >(uniq_linebuffered) &
    vol_pid=$!

    # date
    while true ; do
        date +'date_min %b %d %A '%{F$RED}%{F-}' %H:%M'
        sleep 1 || break
    done > >(uniq_linebuffered) &
    date_pid=$!

    # herbstluftwm
    herbstclient --idle

    # exiting; kill stray event-emitting processes
    kill $mpc_pid $vol_pid $date_pid $bat_pid $spot_pid
} 2> /dev/null | {
    TAGS=( $(herbstclient tag_status $monitor) )
    unset TAGS[${#TAGS[@]}]
    time=""
    song="david@nixon"
    windowtitle="Welcome home David"
    visible=true

        while true ; do
        echo -n "%{l}"
        for i in "${TAGS[@]}" ; do
            case ${i:0:1} in
                '#') # current tag
                    echo -n "%{U$RED}%{+u}"
                    ;;
                '+') # active on other monitor
                    echo -n "%{U$YLW}%{+u}"
                    ;;
                ':')
                    echo -n "%{-u}"
                    ;;
                '!') # urgent tag
                    echo -n "%{U$YLW}"
                    ;;
                *)
                    echo -n "%{-u}"
                    ;;
            esac
            echo -n " ${i:1} "
        done

	echo -n "%{c}$st%{F$GRA}${windowtitle//^/^^} %{F-}"

        # align right
        echo -n "%{r}"
        echo -n "$sm"
        echo -n "$sv"
        echo -n "$volume "
        #echo -n "$sd"
        echo -n "$date "
	echo -n "$Battery"
        echo ""
        # wait for next event
        read line || break
        cmd=( $line )
        # find out event origin
        case "${cmd[0]}" in
            tag*)
                TAGS=( $(herbstclient tag_status $monitor) )
                unset TAGS[${#TAGS[@]}]
                ;;
            mpd_player|player)
                song="$(mpc -f %artist% current)"
		song2="$(mpc -f %title% current)"
                ;;
            vol)
                volume="${cmd[@]:1}"
                ;;
            date_min)
                date="${cmd[@]:1}"
                ;;
	    bat)
                Battery="${cmd[@]:1}"
                ;;
	    focus_changed|window_title_changed)
                windowtitle="${cmd[@]:2}"
                ;;
            quit_panel)
                exit
                ;;
            reload)
                exit
                ;;
        esac
    done
} 2> /dev/null | lemonbar   -g "$(printf '%dx%d%+d%+d' $width $height $x $y)" -u 3 -B ${BG} -F ${FG} -f ${FONT} -f ${FONT2} -f ${FONT3} & $1 | while read line ; do
    case "$line" in
        layout_*)
                layout="${line#layout_}"
                herbstclient emit_hook keyboard_layout "$layout"
                FLAGS=( -option compose:menu -option ctrl:nocaps
                        -option compose:ralt -option compose:rctrl )
                case "$layout" in
                    us) FLAGS+=( -variant altgr-intl ) ;;
                    *) ;;
                esac
                setxkbmap "${FLAGS[@]}" "$layout"
            ;;
        use_*) herbstclient chain , focus_monitor "$monitor" , use "${line#use_}" ;;
        next)  herbstclient chain , focus_monitor "$monitor" , use_index +1 --skip-visible ;;
        prev)  herbstclient chain , focus_monitor "$monitor" , use_index -1 --skip-visible ;;
        switchuser) gdmflexiserver switch-to-greeter
    esac
done
