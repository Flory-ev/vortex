{ pkgs, ... }:
{
  boot.kernel.sysctl."vm.max_map_count" = 2147483642;

  environment.sessionVariables = {
    STEAM_RUNTIME_PREFER_HOST_LIBRARIES = "0";
    WINE_FULLSCREEN_FSR = "1";
    WINE_FULLSCREEN_FSR_STRENGTH = "2";
    PROTON_ENABLE_NVAPI = "1";
    PROTON_HIDE_NVIDIA_GPU = "0";
  };

  hardware.graphics.enable32Bit = true;
  services.pipewire.alsa.support32Bit = true;

  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    gamemode = {
      enable = true;
      settings = {
        general = {
          renice = -10;
          softrealtime = "auto";
        };
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode' 'Optimizations activated'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode' 'Optimizations deactivated'";
        };
        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          gpu_device = 0;
          nv_powermizer_mode = 1;
        };
      };
    };
  };
}
