{
  imports = [
    ./zsh.nix
    ./modules
  ];

  home = {
    username = "irykov";
    homeDirectory = "/home/irykov";
    stateVersion = "24.11";
  };
}
