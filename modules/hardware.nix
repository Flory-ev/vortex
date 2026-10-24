{ ... }:
{
  boot.kernelParams = [
    "nvidia-drm.fbdev=1"
  ];

  hardware = {
    graphics.enable = true;

    nvidia = {
      modesetting.enable = true;
      open = true;
      powerManagement.enable = true;
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
