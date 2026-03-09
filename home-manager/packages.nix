{pkgs,...}:{
    home.packages = with pkgs; [
        
        # desktop apps
        vscode
        firefox
        steam
        obsidian
        libreoffice
        thunar
        yandex-music
        osu-lazer-bin
        telegram-desktop

        #hyprstuff
        hyprshot
        hyprlock


        # cli 
        fastfetch # yes...
        filebrowser
        ranger   # filemanager
        htop     # taskmanager
        btop     # better than htop
        lux      # download video
        lazygit  # git tui
        cava     # tui audio-v
        

        # wallpaper daemon 
        swww
        matugen

        # viewers
        imv
        mpv
        gucharmap

        # notify
        libnotify

        # screencapture
        wf-recorder
        ffmpeg
        grimblast
        grim
        slurp
        swappy

        # audio
        pipewire
        pulseaudio
        pamixer
    ];
}