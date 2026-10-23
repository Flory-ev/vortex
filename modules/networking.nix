{
  networking = {
    firewall.enable = true;
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi = {
        backend = "iwd";
        powersave = false;
      };
    };
    wireless.iwd = {
      enable = true;
      settings = {
        General.RoamRetryInterval = 15;
        Rank.BandModifier5Ghz = 5.0;
      };
    };
  };

  services = {
    resolved.enable = true;
  };
}
