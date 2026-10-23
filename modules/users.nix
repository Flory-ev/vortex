{ pkgs, ... }:
{
  programs.fish.enable = true;

  users.users.f = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "audio"
      "networkmanager"
      "libvirtd"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.f = import ../users/f/default.nix;
  };
}
