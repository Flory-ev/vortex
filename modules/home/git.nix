{ config, lib, ... }:
let
  cfg = config.my.git;
in
{
  options.my.git = {
    enable = lib.mkEnableOption "git with a configured identity";
    name = lib.mkOption { type = lib.types.str; };
    email = lib.mkOption { type = lib.types.str; };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      settings.user = { inherit (cfg) name email; };
    };
  };
}
