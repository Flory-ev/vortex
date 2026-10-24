{ ... }:
{
  networking = {
    hostName = "vortex";

    firewall.enable = true;

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";

      wifi = {
        backend = "iwd";
        powersave = false;
      };
    };
  };

  services.resolved.enable = true;
}
