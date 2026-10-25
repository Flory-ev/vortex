{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    {
      nixosConfigurations.vortex = nixpkgs.lib.nixosSystem {
        modules = [
          home-manager.nixosModules.home-manager
          ./hardware-configuration.nix
          ./modules/boot.nix
          ./modules/desktop.nix
          ./modules/gaming.nix
          ./modules/hardware.nix
          ./modules/networking.nix
          ./modules/nix.nix
          ./modules/system.nix
          ./modules/users.nix
          ./modules/virtualisation.nix
        ];
      };
    };
}
