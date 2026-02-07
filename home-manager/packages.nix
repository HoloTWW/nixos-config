{
    home.packages = with pkgs; [
        
        # desktop apps
        vscode
        firefox
        steam
        obsidian
        libreoffice


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

        # viewers
        imv
        mpv

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