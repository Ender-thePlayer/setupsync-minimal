#!/usr/bin/env bash

pip=(
"python-dotenv"
"pygobject"
"spotify_dl"
"pycryptodome"
)


### PIP
current=$( pwd )
cd "$HOME" || return
uv venv
# shellcheck disable=SC1090
source "$HOME".venv/bin/activate
for pkg in "${pip[@]}"; do
    uv pip install "$pkg"
done
cd "$current" || return