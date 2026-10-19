#!/usr/bin/env bash

current=$(hyprctl activeworkspace -j | jq '.id')

if [ "$(hyprctl activeworkspace -j | jq '.windows')" -gt 0 ]; then
    hyprctl dispatch workspace empty
else
    hyprctl dispatch workspace previous
fi
