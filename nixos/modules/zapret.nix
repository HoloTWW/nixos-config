{ config, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.modules.zapret;
in
{
  options.modules.zapret.enable = mkEnableOption "Enable zapret";

  config = mkIf cfg.enable {
    services.zapret-discord-youtube = {
      enable = true;
      config = "general(ALT7)";
    };
  };
}