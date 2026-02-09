{config, lib, pkgs, ...}:
let
  dotfilesPath = "/home/irykov/nix/home-manager/dotfiles";

  files = [
    "quickshell/shell.qml"
    "quickshell/bar/Clock.qml"
    "quickshell/bar/Bar.qml"
    "hypr/hyprland.conf"
    "hypr/configs/binds.conf"
    "hypr/configs/env.conf"
    "hypr/configs/execs.conf"
    "hypr/configs/input.conf"
    "hypr/configs/theme.conf"
    "hypr/configs/windowrules.conf"
    "hypr/configs/workspaces.conf"
  ];
in
{
  home.file = lib.listToAttrs (map (path: {
    name = ".config/${path}";
    value = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/${path}";
    };
  }) files);

  imports = [
    ./modules

    ./packages.nix
  ];

  qt = {
    enable = true;
    platformTheme = "qtct";
    style.name = "kvantum";
  };

  nixpkgs.config.allowUnfree = true;

  home.shellAliases = {
    nixreb = "sudo nixos-rebuild switch --flake /home/irykov/nixos-config/.";
    hmreb = "home-manager switch --flake /home/irykov/nixos-config/. -b backup";
  };
  
  home = {
    username = "irykov";
    homeDirectory = "/home/irykov";
    stateVersion = "25.11";
  };


}
