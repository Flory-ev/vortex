{ ... }:
{
  boot.kernel.sysctl."vm.max_map_count" = 2147483642;

  environment.sessionVariables = {
    STEAM_RUNTIME_PREFER_HOST_LIBRARIES = "0";
    WINE_FULLSCREEN_FSR = "1";
    WINE_FULLSCREEN_FSR_STRENGTH = "2";
  };

  hardware.graphics.enable32Bit = true;

  programs = {
    gamemode = {
      enable = true;
      settings.general = {
        renice = -10;
        softrealtime = "auto";
      };
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

  services.pipewire.alsa.support32Bit = true;
}