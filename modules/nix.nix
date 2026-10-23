{ pkgs, ... }:
{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dde0enMB6oXQ5yOtIyBTD6jLMOx3SoLDA="
    ];
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    nh = {
      enable = true;
      flake = "/etc/nixos";
      clean = {
        enable = true;
        extraArgs = "--keep 3 --keep-since 4d";
      };
    };
  };
}
