{config,...}:
{
  # Turn On OpenGL
  hardware.graphics.enable = true;

  # Enable for 32bit apps such as Steam
  hardware.graphics.enable32Bit = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
}