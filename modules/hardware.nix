{
  boot.kernelParams = [
    "nvidia-drm.fbdev=1"
  ];

  hardware = {
    cpu.amd.updateMicrocode = true;
    graphics.enable = true;

    nvidia = {
      modesetting.enable = true;
      open = true;
      powerManagement.enable = true;
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}