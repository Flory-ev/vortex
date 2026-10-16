{ config, lib, ... }:
{
  options.my.desktop.audio.enable = lib.mkEnableOption "PipeWire (PulseAudio, JACK and ALSA front-ends)";

  config = lib.mkIf config.my.desktop.audio.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa.enable = true;
    };
    users.users.${config.my.user.name}.extraGroups = [ "audio" ];
  };
}
