#!/bin/bash

#!/bin/bash

function wait_for_key() {
    local key="$1"
    echo "You selected: $key"

    if [ "$key" == "8" ]; then
        hyprctl keyword dwindle:special_scale_factor 0.87
    elif [ "$key" == "7" ]; then
        hyprctl keyword dwindle:special_scale_factor 1
    elif [ "$key" == "9" ]; then
        hyprctl keyword dwindle:special_scale_factor 0.6
    else
        notify-send -u low "No scale factor"
    fi
}

# Prompt user to enter a key using zenity
selected_key=$(zenity --entry --title "Select Scale Factor" --text "Enter 7, 8, or 9:" --width=200 --hide-text=false)

# Pass the selected key to the function
if [[ "$selected_key" =~ ^[789]$ ]]; then
    wait_for_key "$selected_key"
else
    notify-send -u low "Invalid selection"
fi
