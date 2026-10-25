{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    {
      nixosConfigurations.vortex = nixpkgs.lib.nixosSystem {
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix
        ];
      };
    };
}
