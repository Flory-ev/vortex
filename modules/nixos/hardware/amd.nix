{ config, lib, ... }:
let
  cfg = config.my.hardware.amd;
in
{
  options.my.hardware.amd = {
    enable = lib.mkEnableOption "AMD CPU support (microcode, amd_pstate active mode)";
    governor = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "performance";
      description = "CPU frequency governor; null leaves the system default.";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.cpu.amd.updateMicrocode = true;
    boot.kernelParams = [ "amd_pstate=active" ];
    powerManagement.cpuFreqGovernor = lib.mkIf (cfg.governor != null) cfg.governor;
  };
}
