{ pkgs, ... }:
{
  users.users.f = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "audio"
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.f = import ../users/f/default.nix;
  };
}