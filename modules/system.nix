{
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
  ];

  security.sudo-rs.enable = true;

  services = {
    earlyoom = {
      enable = true;
      freeMemThreshold = 5;
      freeSwapThreshold = 10;
    };

    fstrim.enable = true;
    fwupd.enable = true;
  };

  time.timeZone = "Europe/Copenhagen";

  zramSwap.enable = true;
}