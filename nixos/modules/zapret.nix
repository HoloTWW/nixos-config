{ config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.modules.zapret;
in
{
  options.modules.zapret.enable = mkEnableOption "Enable zapret";

  config = mkIf cfg.enable {
    # Используем кавычки для имени опции, чтобы Nix не путал её с системным config
    services.zapret-discord-youtube = {
      enable = false;
      "config" = "general(ALT9)"; 
    };
  };
}
