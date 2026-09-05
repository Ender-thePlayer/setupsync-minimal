#!/usr/bin/env bash
### CREATED ON: 19.05.2024
### It prints out the CPU temperature and frequency, GPU temperature
### and the CPU fan speed as a JSON formatted string used for the bar (wayle)

# Usage: "hardware.sh"


get_cpu_temp() {
    sensors coretemp-isa-0000 2>/dev/null | grep "Package id 0:" | awk '{print $4}' | sed 's/+//;s/°C//'
}

get_cpu_fan() {
    sensors thinkpad-isa-0000 2>/dev/null | grep "^fan1:" | awk '{print $2}'
}

get_cpu_freq() {
    if [ -f /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq ]; then
        freq=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq)
        echo "scale=0; $freq / 1000" | bc
    else
        echo "0"
    fi
}

cpu_temp=$(get_cpu_temp)
cpu_fan=$(get_cpu_fan)
cpu_freq=$(get_cpu_freq)

echo "{\"cputemp\": \"${cpu_temp}°C\", \"freq\": \"${cpu_freq}MHz\", \"rpm\": \"${cpu_fan}RPM\"}"
