{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.my.desktop.fonts.enable = lib.mkEnableOption "the system font set";

  config = lib.mkIf config.my.desktop.fonts.enable {
    fonts.packages = with pkgs; [
      font-awesome
      jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];
  };
}
