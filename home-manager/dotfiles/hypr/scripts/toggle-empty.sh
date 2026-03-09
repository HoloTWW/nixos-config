#!/bin/bash
# Получаем ID текущего воркспейса
current=$(hyprctl activeworkspace -j | jq '.id')

# Если на воркспейсе есть окна (он не пустой), прыгаем на пустой
if [ "$(hyprctl activeworkspace -j | jq '.windows')" -gt 0 ]; then
    hyprctl dispatch workspace empty
else
    # Если окон нет (мы уже на пустом), возвращаемся на предыдущий
    hyprctl dispatch workspace previous
fi
