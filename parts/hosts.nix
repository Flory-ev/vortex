{ inputs, ... }:
let
  mkHost =
    name:
    {
      system ? "x86_64-linux",
    }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        inputs.home-manager.nixosModules.home-manager
        ../modules/nixos
        ../hosts/${name}
        { networking.hostName = name; }
      ];
    };
in
{
  flake.nixosConfigurations = {
    vortex = mkHost "vortex" { };
  };
}
