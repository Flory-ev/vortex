{ config, lib, ... }:
let
  cfg = config.my.hardening;
in
{
  options.my.hardening.enable = lib.mkEnableOption "kernel info-leak sysctls and sudo-rs";

  config = lib.mkIf cfg.enable {
    security.sudo-rs.enable = true;
    boot.kernel.sysctl = {
      "kernel.dmesg_restrict" = true;
      "kernel.kptr_restrict" = 2;
      "kernel.unprivileged_bpf_disabled" = 1;
    };
  };
}
