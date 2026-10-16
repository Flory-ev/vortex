{ config, lib, ... }:
let
  cfg = config.my.memory;
in
{
  options.my.memory.enable = lib.mkEnableOption "zram swap, earlyoom and low swappiness";

  config = lib.mkIf cfg.enable {
    zramSwap.enable = true;
    boot.kernel.sysctl."vm.swappiness" = 10;
    services.earlyoom = {
      enable = true;
      freeMemThreshold = 5;
      freeSwapThreshold = 10;
    };
  };
}
