#!/usr/bin/env bash

fan_speed=$(sensors nct6796-isa-0290 | awk '/^fan2:/ {print $2}')
echo "$fan_speed"


