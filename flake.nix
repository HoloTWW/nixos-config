{
  description = "An experimental setup of nixos flake";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pixie-sddm = {
      url = "github:xCaptaiN09/pixie-sddm";
      flake = false; # just theme not nix project
    };

    zapret = {
      url = "github:kartavkun/zapret-discord-youtube";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, zapret, ... }@inputs:
    let 
      system = "x86_64-linux";
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        
        specialArgs = { inherit inputs; };
        modules = [ 
          ./nixos/configuration.nix
          zapret.nixosModules.default 
          ];
      };

      homeConfigurations.irykov = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ ./home-manager/home.nix ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
}
