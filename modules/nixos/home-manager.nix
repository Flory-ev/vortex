{ config, inputs, ... }:
let
  user = config.my.user;
in
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    sharedModules = [ ../home ];
    users.${user.name}.imports = [ user.homeModule ];
  };
}
