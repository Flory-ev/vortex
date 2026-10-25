{ ... }:
{
  boot = {
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
