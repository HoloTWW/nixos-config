#!/usr/bin/env bash

SAVE_DIR="$HOME/Videos/Recordings"
# Временный файл для сырой записи (быстрый захват)
TMP_RAW="/tmp/raw_rec_$(id -u).mp4"
mkdir -p "$SAVE_DIR"

if pgrep -x "wf-recorder" > /dev/null; then
    pkill -INT -x wf-recorder
    while pgrep -x "wf-recorder" > /dev/null; do sleep 0.1; done
    
    FILENAME="$SAVE_DIR/vid_$(date +%Y%m%d_%H%M%S).mp4"
    
    notify-send "🎬 Compressing..." -a "Hyprland Recorder"
    
    # Сжатие: libx264, crf 28 (хороший баланс веса/качества), формат пикселей yuv420p для совместимости
    ffmpeg -i "$TMP_RAW" -c:v libx264 -crf 28 -preset fast -pix_fmt yuv420p "$FILENAME" -y
    
    # Копирование пути и самого файла в буфер (через wl-copy)
    # Примечание: некоторые мессенджеры подхватят как файл
    cliphist store < "$FILENAME"
    wl-copy < "$FILENAME" --type video/mp4
    
    rm "$TMP_RAW"
    notify-send "Capture It!" "Size: $(du -h "$FILENAME" | cut -f1)" -i video-x-generic -a "Hyprland Recorder"
else
    GEOM=$(slurp -b "#00000044" -c "#8888ff88" -w 2)
    [ -z "$GEOM" ] && exit 1
    
    notify-send "Recording..." "Win+Shift+R to stop" -a "Hyprland Recorder"
    # Записываем без лишней нагрузки на CPU, пожмем потом
    wf-recorder -g "$GEOM" -f "$TMP_RAW"
fi
