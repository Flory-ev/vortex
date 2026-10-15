{ pkgs, ... }:
{
  imports = [
    ./modules/boot.nix
    ./modules/hardware.nix
    ./modules/networking.nix
    ./modules/desktop.nix
    ./modules/nix.nix
    ./modules/gaming.nix
    ./modules/virtualization.nix
  ];

  networking.hostName = "vortex";
  system.stateVersion = "26.05";

  time.timeZone = "Europe/Copenhagen";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ru_RU.UTF-8/UTF-8"
  ];
  console.keyMap = "us";

  programs.fish.enable = true;
  security.sudo-rs.enable = true;

  services = {
    earlyoom = {
      enable = true;
      freeMemThreshold = 5;
      freeSwapThreshold = 10;
    };
    fstrim.enable = true;
    fwupd.enable = true;
  };
  zramSwap.enable = true;

  users.users.f = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "audio"
      "networkmanager"
      "wheel"
    ];
  };
}
