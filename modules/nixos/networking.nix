{ config, lib, ... }:
let
  cfg = config.my.networking;
in
{
  options.my.networking = {
    enable = lib.mkEnableOption "NetworkManager (iwd backend), systemd-resolved and a firewall";
    mullvad.enable = lib.mkEnableOption "Mullvad VPN";
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        networking = {
          networkmanager = {
            enable = true;
            dns = "systemd-resolved";
            wifi = {
              backend = "iwd";
              powersave = false;
            };
          };
          firewall.enable = true;
          wireless.iwd = {
            enable = true;
            settings = {
              General.RoamRetryInterval = 15;
              Rank.BandModifier5Ghz = 5.0;
            };
          };
        };
        services.resolved.enable = true;
        users.users.${config.my.user.name}.extraGroups = [ "networkmanager" ];
      }

      (lib.mkIf cfg.mullvad.enable { services.mullvad-vpn.enable = true; })
    ]
  );
}
