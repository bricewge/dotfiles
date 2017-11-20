#!/usr/bin/env sh


bspc subscribe monitor | while read -r line; do
    echo $line
    case $line in
        monitor_add*)
            MONITOR=$(echo $line | cut -d ' ' -f3) polybar --reload example &
            ;;
        monitor_remove*)
            monitor_name=$(bspc query --monitors --names --monitor $(echo $line | cut -d ' ' -f2))
            for pid in $(pidof polybar); do
                monitor_env=$(sed 's:\x0:\n:g' /proc/$pid/environ | grep 'MONITOR=' | cut -d '=' -f2)
                if [[ $monitor_name == $monitor_env ]]; then
                    kill $pid
                fi
            done
            ;;
        *)
            ;;
    esac
done &
