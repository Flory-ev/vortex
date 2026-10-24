{ ... }:
{
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  security.rtkit.enable = true;

  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
    flatpak.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
  };
}
