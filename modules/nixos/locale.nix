{ config, lib, ... }:
let
  cfg = config.my.locale;
in
{
  options.my.locale = {
    timeZone = lib.mkOption {
      type = lib.types.str;
      default = "UTC";
    };
    keyMap = lib.mkOption {
      type = lib.types.str;
      default = "us";
    };
  };

  config = {
    time.timeZone = cfg.timeZone;
    i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];
    console.keyMap = cfg.keyMap;
  };
}
