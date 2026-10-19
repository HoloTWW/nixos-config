{
  # Loading Screen
  boot.plymouth.enable = true;
  
  # Silent Boot, Press ESC while loading system to show logs
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.kernelParams = [ 
    "quiet" 
    "splash" 
    "boot.shell_on_fail" 
    "loglevel=3" 
    "rd.systemd.show_status=false" 
    "rd.udev.log_level=3" 
    "udev.log_priority=3" 
  ];

  boot.initrd.kernelModules = [ "nvidia" ];
  boot.loader.systemd-boot.consoleMode = "max";
}