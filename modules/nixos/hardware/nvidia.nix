{ config, lib, ... }:
let
  cfg = config.my.hardware.nvidia;
in
{
  options.my.hardware.nvidia = {
    enable = lib.mkEnableOption "the proprietary NVIDIA driver stack";
    open = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Use NVIDIA's open kernel modules (Turing and newer).";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.kernelParams = [ "nvidia-drm.fbdev=1" ];
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware = {
      graphics.enable = true;
      nvidia = {
        modesetting.enable = true;
        powerManagement.enable = true;
        inherit (cfg) open;
      };
    };
  };
}
