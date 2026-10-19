{ config, inputs, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./packages.nix
      ./modules/bundle.nix
    ];

  # Великий фикс проклятых драйверов спикеров на huawei d15 bob-wai9
  hardware.huaweiEs8336Sound.enable = true;

  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };

  # -- Управляю ноутом

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
    };
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.tlp = {
    enable = true;
    settings = {
      # Запрещаем отключать питание для переходника Naxiang (35b5:3500)
      USB_EXCLUDE_IDS = "35b5:3500";
    };
  };

  # Bootloader UEFI.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk 
    ];
    config.common.default = [ "hyprland" "gtk" ];
    # Явно укажем использование hyprland для ввода, если возможно
    config.hyprland.default = [ "hyprland" "gtk" ];
  };

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  networking.firewall.allowedTCPPorts = [ 24800 8080 22];


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
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # sddm
  services.displayManager.sddm = {
    enable = true;
    theme = "pixie";
    autoLogin.relogin = false;
    
  };

  services.displayManager.autoLogin = {
    enable = true;
    user = "irykov";
  };
  
  environment.systemPackages = [
    (pkgs.stdenv.mkDerivation {
      name = "pixie-sddm";
      src = inputs.pixie-sddm;
      installPhase = ''
        mkdir -p $out/share/sddm/themes/pixie
        cp -r * $out/share/sddm/themes/pixie/
      '';
    })
  ];
  

  programs.hyprland.enable = true;  

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };


  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.upower.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable hdd visor
  services.udisks2.enable = true;
  security.polkit.enable = true;
  services.gvfs.enable = true;

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if ((action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
          action.id == "org.freedesktop.udisks2.filesystem-mount") &&
          subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  system.stateVersion = "25.11"; # Don`t change it plz

}
