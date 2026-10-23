{
  imports = [
    ./hardware-configuration.nix
    ../../modules/boot.nix
    ../../modules/nix.nix
    ../../modules/users.nix
    ../../modules/hardware.nix
    ../../modules/desktop.nix
    ../../modules/networking.nix
    ../../modules/system.nix
    ../../modules/gaming.nix
    ../../modules/virtualisation.nix
  ];

  system.stateVersion = "26.05";
  networking.hostName = "vortex";
}
