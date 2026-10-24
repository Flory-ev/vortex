{ ... }:
{
  boot = {
    initrd.systemd.enable = true;
    kernelParams = [ "quiet" ];

    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 1;

      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        consoleMode = "max";
        editor = false;
      };
    };
  };
}
