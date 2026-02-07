{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./packages.nix
      ./modules/bundle.nix
    ];
 
  # VM legacy
  #boot.loader.grub.enable = true;
  #boot.loader.grub.device = "/dev/sda";

  # Bootloader UEFI.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  # Flake
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  
  
  services.xserver.desktopManager.gnome.enable = true;

  # sddm
  services.displayManager.sddm = {
    package = pkgs.kdePackages.sddm;
    enable = true;
    # Note: Use "sddm-astronaut-theme", not "sddm-astronaut"
    theme = "sddm-astronaut-theme";
    # Necessary for the theme's graphics/animations
    extraPackages = [ 
      pkgs.kdePackages.qtmultimedia 
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.qt5compat
    ];
  };  

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  
  system.stateVersion = "25.11"; # Don`t change it plz

}
