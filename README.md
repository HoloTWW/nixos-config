# Minimalistic NixOS Configuration

## Features

- Flake
- Home-Manager

- Hyprland
- Quickshell


## System Requirements
- NixOS 24.11
- <strong>NO NVIDIA CARD</strong>

## Clear Install

1. Install NixOS 24.11 
(I recomend you to install with GUI to easy setup wifi (if u have laptop))

2. Pre-install git
```bash
nix-shell -p git
```

3. Clone this repo
```bash
# it will be there: ~/nix/
git clone https://github.com/HoloTWW/nixos-config.git nix
```

4. Copy your hardware-configuration
```bash
cp /etc/nixos/hardware-configuration ~nix/nixos
```

5. Rebuild system and home-manager
```bash
sudo nixos-rebuild switch --flake .
home-manager switch --flake .
```  

> [!WARNING]
>
> The user in this configuration is <strong>irykov</strong>, to change user you should change the following files (replace <strong>irykov</strong> with your <strong>username</strong>):
> - ~nix/nixos/modules/user.nix 
> - ~nix/home-manager/home.nix
