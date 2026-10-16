{ config, lib, ... }:
{
  options.my.maintenance.enable = lib.mkEnableOption "periodic TRIM and firmware updates (fwupd)";

  config = lib.mkIf config.my.maintenance.enable {
    services = {
      fstrim.enable = true;
      fwupd.enable = true;
    };
  };
}
