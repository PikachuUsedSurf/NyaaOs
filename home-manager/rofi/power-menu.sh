#!/bin/sh
entries="🌸 Logout\n😴 Suspend\n🔄 Reboot\n⏻ Shutdown"

selected=$(echo -e "$entries" | rofi -dmenu -p "Power Menu" -theme ~/.config/rofi/config.rasi)

case $selected in
    "🌸 Logout")
        hyprctl dispatch exit;;
    "😴 Suspend")
        systemctl suspend;;
    "🔄 Reboot")
        systemctl reboot;;
    "⏻ Shutdown")
        systemctl poweroff;;
esac