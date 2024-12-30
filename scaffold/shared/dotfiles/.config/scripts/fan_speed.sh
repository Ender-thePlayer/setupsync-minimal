#!/bin/bash

fan_speed=$(sensors | grep -i 'fan1' | awk '{print $2}')
echo "${fan_speed}"

