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

        #hyprstuff
        hyprshot


        # cli 
        fastfetch # yes...
        filebrowser
        ranger   # filemanager
        htop     # taskmanager
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

        # screenshoots
        grim
        grimblast
        slurp
        swappy

        # audio
        pipewire
        pulseaudio
        pamixer
    ];
}