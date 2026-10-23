{ ... }:
{

  system.stateVersion = "26.05";

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  nixpkgs.config.allowUnfree = true;

  programs.nh = {
    enable = true;
    flake = "/etc/nixos";

    clean = {
      enable = true;
      extraArgs = "--keep 3 --keep-since 4d";
    };
  };
}