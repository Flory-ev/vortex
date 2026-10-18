{
  imports = [ ./hardware-configuration.nix ];

  system.stateVersion = "26.05";

  my = {
    user = {
      name = "f";
      homeModule = ../../users/f;
    };

    locale = {
      timeZone = "Europe/Copenhagen";
    };

    hardware = {
      amd = {
        enable = true;
        governor = "performance";
      };
      nvidia.enable = true;
      bluetooth = {
        enable = true;
        experimental = true;
      };
    };

    desktop = {
      cosmic.enable = true;
      audio.enable = true;
      fonts.enable = true;
      flatpak.enable = true;
      appimage.enable = true;
    };

    networking = {
      enable = true;
      mullvad.enable = true;
    };

    memory.enable = true;
    hardening.enable = true;
    maintenance.enable = true;

    gaming.enable = true;
    virtualisation.libvirt.enable = true;
  };
}
