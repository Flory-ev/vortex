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
      spotify
      telegram-desktop
      termius
      tutanota-desktop
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
      extraConfig = ''
        Host *
          IdentityAgent ~/.bitwarden-ssh-agent.sock
      '';
    };
    starship = {
      enable = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[❯](bold green)";
          error_symbol = "[❯](bold red)";
        };
        git_branch = {
          symbol = "🌱 ";
        };
      };
    };
    zed-editor = {
      enable = true;
      extensions = [ "nix" ];
    };
    zoxide.enable = true;
  };
}
