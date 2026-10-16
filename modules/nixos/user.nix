{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.user;
in
{
  options.my.user = {
    name = lib.mkOption {
      type = lib.types.str;
      description = "Login name of the primary user.";
    };
    homeModule = lib.mkOption {
      type = lib.types.path;
      description = "home-manager module (file or directory) for the primary user.";
    };
  };

  config = {
    programs.fish.enable = true;

    # Feature modules append their own groups (audio, networkmanager, libvirtd, ...).
    users.users.${cfg.name} = {
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = [ "wheel" ];
    };
  };
}
