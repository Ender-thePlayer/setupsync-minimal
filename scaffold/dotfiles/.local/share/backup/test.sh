#!/usr/bin/env bash
drive="$(cd "$URL" && cd .. && pwd)"
echo $drive >> /home/ender/h.txt
