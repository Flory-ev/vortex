# Desktop apps grouped by purpose. Each group becomes `my.apps.<group> = true;`.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  groups = with pkgs; {
    archive = [ peazip ];
    communication = [
      signal-desktop
      telegram-desktop
      tutanota-desktop
    ];
    security = [ bitwarden-desktop ];
    media = [ spotify ];
    utilities = [ dust ];
    windows = [ wineWow64Packages.stable ];
  };
in
{
  options.my.apps = lib.mapAttrs (name: _: lib.mkEnableOption "the ${name} app group") groups;

  config.home.packages = lib.concatLists (
    lib.mapAttrsToList (name: packages: lib.optionals config.my.apps.${name} packages) groups
  );
}
