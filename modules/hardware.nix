{
  boot.kernelParams = [
    "amd_pstate=active"
    "nvidia-drm.fbdev=1"
  ];

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Experimental = true;
    };

    cpu.amd.updateMicrocode = true;
    graphics.enable = true;

    nvidia = {
      modesetting.enable = true;
      open = true;
      powerManagement.enable = true;
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  powerManagement.cpuFreqGovernor = "performance";
}
