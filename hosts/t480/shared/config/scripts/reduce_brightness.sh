#!/usr/bin/env bash

current_brightness=$(brightnessctl g)
max_brightness=$(brightnessctl m)
min_brightness=$(echo "$max_brightness * 0.20" | bc)

steps=30
delay=0.001

brightness_file="/tmp/previous_brightness"

if [ -f "$brightness_file" ]; then
    previous_brightness=$(cat "$brightness_file")
    step_increase=$(echo "($previous_brightness - $current_brightness) / $steps" | bc -l)
    
    for ((i = 0; i < steps; i++)); do
        new_brightness=$(echo "$current_brightness + ($i + 1) * $step_increase" | bc -l)

        if (( $(echo "$new_brightness >= $previous_brightness" | bc -l) )); then
            new_brightness=$previous_brightness
        fi

        brightnessctl s "$(printf "%.0f" "$new_brightness")"
        sleep $delay
    done
    
    rm "$brightness_file"
else
    echo "$current_brightness" > "$brightness_file"

    step_decrease=$(echo "($current_brightness - $min_brightness) / $steps" | bc -l)

    for ((i = 0; i < steps; i++)); do
        new_brightness=$(echo "$current_brightness - ($i + 1) * $step_decrease" | bc -l)

        if (( $(echo "$new_brightness <= $min_brightness" | bc -l) )); then
            new_brightness=$min_brightness
        fi
        
        brightnessctl s "$(printf "%.0f" "$new_brightness")"

        sleep $delay
    done
fi

