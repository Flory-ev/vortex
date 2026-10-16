{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.gaming;
  nvidia = config.my.hardware.nvidia.enable;
in
{
  options.my.gaming.enable = lib.mkEnableOption "Steam, Gamescope, GameMode and Proton tweaks";

  config = lib.mkIf cfg.enable {
    boot.kernel.sysctl."vm.max_map_count" = 2147483642;

    # NVIDIA-only tweaks follow the hardware module instead of being hard-wired.
    environment.sessionVariables = {
      STEAM_RUNTIME_PREFER_HOST_LIBRARIES = "0";
      WINE_FULLSCREEN_FSR = "1";
      WINE_FULLSCREEN_FSR_STRENGTH = "2";
    }
    // lib.optionalAttrs nvidia {
      PROTON_ENABLE_NVAPI = "1";
      PROTON_HIDE_NVIDIA_GPU = "0";
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    services.pipewire.alsa.support32Bit = true;

    programs = {
      gamemode = {
        enable = true;
        settings = lib.mkMerge [
          {
            general = {
              renice = -10;
              softrealtime = "auto";
            };
            custom = {
              start = "${pkgs.libnotify}/bin/notify-send 'GameMode' 'Optimizations activated'";
              end = "${pkgs.libnotify}/bin/notify-send 'GameMode' 'Optimizations deactivated'";
            };
          }
          (lib.mkIf nvidia {
            gpu = {
              apply_gpu_optimisations = "accept-responsibility";
              gpu_device = 0;
              nv_powermizer_mode = 1;
            };
          })
        ];
      };
      gamescope = {
        enable = true;
        capSysNice = true;
      };
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
    };
  };
}
