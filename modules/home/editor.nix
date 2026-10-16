{ config, lib, ... }:
let
  cfg = config.my.editor.zed;
in
{
  options.my.editor.zed = {
    enable = lib.mkEnableOption "the Zed editor";
    extensions = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  config = lib.mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
      inherit (cfg) extensions;
    };
  };
}
