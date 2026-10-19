{pkgs,...}:{
  
  environment.systemPackages = with pkgs; [
    # gui mixer   
    pavucontrol
  ];

  # disble to avoid conflicts
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    
    # session manager
    wireplumber.enable = true;

    # someday i will go back to the reaper-daw...someday...
    jack.enable = true;
  };

  services.pipewire.wireplumber.extraConfig = {
    "monitor.bluez.properties" = {
      "bluez5.enable-sbc-xq" = true;
      "bluez5.enable-msbc" = true;
      "bluez5.enable-hw-volume" = true;
      "bluez5.roles" = [ "a2dp_sink" "a2dp_source" "headset_head_unit" "headset_audio_gateway" ];
    };
    "10-bluetooth-policy" = {
      "monitor.bluez.properties" = {
        "bluez5.enable-hw-volume" = true; # sync system volume (idk will it works)
      };
    };
  };
}