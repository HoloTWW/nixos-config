#!/bin/bash

# Имя вашей светлой темы GTK
LIGHT_THEME="Adwaita"
# Имя вашей темной темы GTK
DARK_THEME="Adwaita-dark"

# Функция для получения текущей темы GTK
get_current_theme() {
  gsettings get org.gnome.desktop.interface gtk-theme
}

# Функция для установки темы GTK
set_theme() {
  theme="$1"
  prefer=""

  if [[ "$theme" == "$DARK_THEME" ]]; then
    prefer="light"
  else
    prefer="dark"
  fi

  gsettings set org.gnome.desktop.interface cursor-theme "$theme" # Опционально, если хотите менять тему курсора

  #GTK4
  gsettings set org.gnome.desktop.interface gtk-theme "$theme"
  gsettings set org.gnome.desktop.interface color-scheme "prefer-$prefer" # "prefer-dark" or "prefer-light"
}


# Получаем текущую тему
current_theme=$(get_current_theme | tr -d "'")

# Переключаем тему
if [[ "$current_theme" == "$DARK_THEME" ]]; then
  set_theme "$LIGHT_THEME"
  echo ""
else
  set_theme "$DARK_THEME"
  echo "󰖨"
fi

exit 0
