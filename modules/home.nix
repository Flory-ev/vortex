{ pkgs, ... }:
{
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    alacritty
    ardour
    bitwarden-desktop
    burpsuite
    fuzzel
    peazip
    reaper
    signal-desktop
    spotify
    telegram-desktop
    tutanota-desktop
    wineWow64Packages.stable
  ];

  programs = {
    bat.enable = true;
    eza.enable = true;
    fd.enable = true;
    firefox.enable = true;
    fish.enable = true;
    ripgrep.enable = true;
    starship.enable = true;
    zoxide.enable = true;

    git = {
      enable = true;
      settings.user = {
        email = "tkachuk@tuta.com";
        name = "F";
      };
    };

    ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings."*".IdentityAgent = "~/.bitwarden-ssh-agent.sock";
    };

    zed-editor = {
      enable = true;
      extensions = [ "nix" ];
    };
  };
}
