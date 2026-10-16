{ config, lib, ... }:
let
  cfg = config.my.hardware.bluetooth;
in
{
  options.my.hardware.bluetooth = {
    enable = lib.mkEnableOption "Bluetooth, powered on at boot";
    experimental = lib.mkEnableOption "BlueZ experimental features";
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Experimental = cfg.experimental;
    };
  };
}
