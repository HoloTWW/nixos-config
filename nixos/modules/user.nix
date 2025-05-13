{pkgs, ...}:{
    programs.zsh.enable = true;

    users = {
        defaultUserShell = pkgs.zsh;

        users.irykov = {
            isNormalUser = true;
            description = "irykov";
            extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" ];
            packages = with pkgs; [];
        };
    };

    services.getty.autologinUser = "irykov";
}