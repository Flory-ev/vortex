{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.nix;
in
{
  options.my.nix.flakePath = lib.mkOption {
    type = lib.types.str;
    default = "/etc/nixos";
    description = "Location of this flake, used by `nh`.";
  };

  config = {
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

    environment.systemPackages = [ pkgs.nixfmt ];

    programs = {
      nh = {
        enable = true;
        flake = cfg.flakePath;
        clean = {
          enable = true;
          extraArgs = "--keep 3 --keep-since 4d";
        };
      };
      nix-ld = {
        enable = true;
        libraries = with pkgs; [
          stdenv.cc.cc
          zlib
        ];
      };
    };
  };
}
