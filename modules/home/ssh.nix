{ config, lib, ... }:
let
  cfg = config.my.ssh;
in
{
  options.my.ssh = {
    enable = lib.mkEnableOption "declarative SSH client config";
    bitwardenAgent.enable = lib.mkEnableOption "Bitwarden's SSH agent socket as the identity agent";
  };

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings."*" = lib.optionalAttrs cfg.bitwardenAgent.enable {
        IdentityAgent = "~/.bitwarden-ssh-agent.sock";
      };
    };
  };
}
