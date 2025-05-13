{ configs, pkgs, ... } : {
  imports = [
    ./modules/bundle.nix
  ];

  home = {
    username = "irykov";
    homeDirectory = "/home/irykov";
    stateVersion = "24.11";
  };
}
