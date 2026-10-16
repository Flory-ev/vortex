{ config, lib, ... }:
{
  options.my.desktop.cosmic.enable = lib.mkEnableOption "the COSMIC desktop and greeter";

  config = lib.mkIf config.my.desktop.cosmic.enable {
    services = {
      desktopManager.cosmic.enable = true;
      displayManager.cosmic-greeter.enable = true;
    };
  };
}
