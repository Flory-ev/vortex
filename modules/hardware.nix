{
  boot.kernelParams = [
    "amd_pstate=active"
    "nvidia-drm.fbdev=1"
  ];

  powerManagement.cpuFreqGovernor = "performance";
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    cpu.amd.updateMicrocode = true;
    graphics.enable = true;
    nvidia = {
      open = true;
      modesetting.enable = true;
      powerManagement.enable = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Experimental = true;
    };
  };
}
