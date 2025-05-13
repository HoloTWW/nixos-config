{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = ["python-2.7.18.8" "electron-25.9.0"];
  };

  programs.thunar.enable = true;
  
  environment.systemPackages = with pkgs; [
    # Desktop
    firefox
    vscode
    foot
    
    # Desktop Launcher
    rofi

    # GUI Utils
    dmenu

    # CLI Utils
    nano
    wget
    curl
    git
    zip     

    # Code
    gcc 
    nodejs
    python
    (python3.withPackages (ps: with ps; [requests]))

    # Wayland
    xwayland
    wl-clipboard
    cliphist

    # WMs
    hyprland
    seatd
    xdg-desktop-portal-hyprland
    waybar

    # Sound
    pipewire
    pulseaudio
    pamixer

    # Screenshoots
    swappy

    # System
    home-manager
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    papirus-nord
    firefox

  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    (nerdfonts.override { fonts = ["NerdFontsSymbolsOnly"]; })
  ];
}
