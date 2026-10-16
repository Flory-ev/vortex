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
    extraLocales = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = [ "ru_RU.UTF-8/UTF-8" ];
      description = "Locales to generate in addition to en_US.UTF-8.";
    };
    keyMap = lib.mkOption {
      type = lib.types.str;
      default = "us";
    };
  };

  config = {
    time.timeZone = cfg.timeZone;
    i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ] ++ cfg.extraLocales;
    console.keyMap = cfg.keyMap;
  };
}
