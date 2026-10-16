{ config, lib, ... }:
let
  cfg = config.my.desktop;
in
{
  options.my.desktop = {
    flatpak.enable = lib.mkEnableOption "Flatpak";
    appimage.enable = lib.mkEnableOption "AppImage support via binfmt";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.flatpak.enable { services.flatpak.enable = true; })
    (lib.mkIf cfg.appimage.enable {
      programs.appimage = {
        enable = true;
        binfmt = true;
      };
    })
  ];
}
