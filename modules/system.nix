{
  time.timeZone = "Europe/Copenhagen";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];

  zramSwap.enable = true;
  security.sudo-rs.enable = true;

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "kernel.dmesg_restrict" = true;
    "kernel.kptr_restrict" = 2;
    "kernel.unprivileged_bpf_disabled" = 1;
  };

  services = {
    earlyoom = {
      enable = true;
      freeMemThreshold = 5;
      freeSwapThreshold = 10;
    };
    fstrim.enable = true;
    fwupd.enable = true;
  };
}
