{ config, lib, ... }:
{
  options.my.shell.enable = lib.mkEnableOption "fish + starship + zoxide and modern CLI replacements";

  config = lib.mkIf config.my.shell.enable {
    programs = {
      bat.enable = true;
      eza.enable = true;
      fd.enable = true;
      fish.enable = true;
      ripgrep.enable = true;
      starship.enable = true;
      zoxide.enable = true;
    };
  };
}
