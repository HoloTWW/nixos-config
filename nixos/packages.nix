{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = ["python-2.7.18.8" "electron-25.9.0"];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    # or specifically for electron apps:
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    };

  # programs.hyprland.enable = true;
  # programs.quickshell.enable = true;
  
  environment.systemPackages = with pkgs; [
    
    # terminal & editor 
    alacritty
    helix

    # hardware stuf
    zram-generator
    brightnessctl
    pcmanfm-qt
    gparted
    ntfs3g

    # tooltip
    gromit-mpx

    # build stuff
    gnumake
    gcc
    nodejs
    python3
    (python3.withPackages (ps: with ps; [ requests ]))

    # must have tools
    nix-index
    openssl
    unzip
    light
    file
    tree
    wget
    zip
    git
    gh
    
    
    # bluetooth protocol
    bluez
    bluez-tools
    

    # wayland stuff
    xwayland
    wl-clipboard
    cliphist
    

    # wm and stuff
    hyprland
    quickshell
    xdg-desktop-portal-hyprland
    seatd

    # big boy
    home-manager

    # dependences 
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    spice-vdagent
    sddm-astronaut
    kdePackages.qtmultimedia
    papirus-nord
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-color-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    nerd-fonts.symbols-only
  ];
}
