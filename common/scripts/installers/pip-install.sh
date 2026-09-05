#!/usr/bin/env bash


### PIP
pip=(
"yt-dlp"
"spotify_dl"
)

for pkg in "${pip[@]}"; do
    uv tool install "$pkg"
done