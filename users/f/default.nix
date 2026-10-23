{ pkgs, ... }:
{
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    signal-desktop
    telegram-desktop
    tutanota-desktop
    bitwarden-desktop
    reaper
    spotify
    burpsuite
    dust
    peazip
    wineWow64Packages.stable
  ];

  programs = {
    bat.enable = true;
    eza.enable = true;
    fd.enable = true;
    fish.enable = true;
    ripgrep.enable = true;
    starship.enable = true;
    zoxide.enable = true;
    firefox.enable = true;
    zed-editor = {
      enable = true;
      extensions = [ "nix" ];
    };
    git = {
      enable = true;
      settings.user = {
        name = "F";
        email = "tkachuk@tuta.com";
      };
    };
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings."*".IdentityAgent = "~/.bitwarden-ssh-agent.sock";
    };
  };
}
