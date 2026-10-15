{ config, pkgs, ... }:
{
  home = {
    username = "f";
    homeDirectory = "/home/f";
    stateVersion = "26.05";
    packages = with pkgs; [
      bitwarden-desktop
      dust
      qbittorrent
      signal-desktop
      spotify
      telegram-desktop
      termius
      tutanota-desktop
      wineWow64Packages.stable
    ];
  };

  programs = {
    bat.enable = true;
    eza.enable = true;
    fd.enable = true;
    firefox.enable = true;
    fish.enable = true;
    git = {
      enable = true;
      settings = {
        user.name = "F";
        user.email = "tkachuk@tuta.com";
      };
    };
    ripgrep.enable = true;
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings."*" = {
        IdentityAgent = "~/.bitwarden-ssh-agent.sock";
      };
    };
    starship.enable = true;
    zed-editor = {
      enable = true;
      extensions = [ "nix" ];
    };
    zoxide.enable = true;
  };
}
