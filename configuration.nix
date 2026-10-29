{ config, pkgs, ... }:
{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        configurationLimit = 10;
        consoleMode = "max";
        enable = true;
      };
      timeout = 1;
    };
  };

  environment.systemPackages = with pkgs; [
    bat
    eza
    fd
    ripgrep
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = false;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];

  networking = {
    hostName = "vortex";
    networkmanager = {
      dns = "systemd-resolved";
      enable = true;
      wifi.backend = "iwd";
    };
  };

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  nixpkgs.config.allowUnfree = true;

  programs = {
    appimage = {
      binfmt = true;
      enable = true;
    };
    firefox.enable = true;
    fish.enable = true;
    gamemode.enable = true;
    gamescope.enable = true;
    git = {
      config.user = {
        email = "tkachuk@tuta.com";
        name = "F";
      };
      enable = true;
    };
    nh = {
      clean = {
        enable = true;
        extraArgs = "--keep 3 --keep-since 4d";
      };
      enable = true;
      flake = "/home/f/vortex";
    };
    ssh.extraConfig = "IdentityAgent ~/.bitwarden-ssh-agent.sock";
    starship.enable = true;
    steam.enable = true;
    zoxide.enable = true;
  };

  security = {
    pam.loginLimits = [
      {
        domain = "@audio";
        item = "memlock";
        type = "-";
        value = "unlimited";
      }
      {
        domain = "@audio";
        item = "rtprio";
        type = "-";
        value = "99";
      }
    ];
    rtkit.enable = true;
    sudo-rs.enable = true;
  };

  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
    flatpak.enable = true;
    fstrim.enable = true;
    fwupd.enable = true;
    pipewire = {
      alsa.enable = true;
      enable = true;
      pulse.enable = true;
    };
    resolved.enable = true;
    xserver.videoDrivers = [ "nvidia" ];
  };

  system.stateVersion = "26.05";

  time.timeZone = "Europe/Copenhagen";

  users.users.f = {
    extraGroups = [
      "audio"
      "networkmanager"
      "wheel"
    ];
    isNormalUser = true;
    packages = with pkgs; [
      bitwarden-desktop
      burpsuite
      reaper
      signal-desktop
      spotify
      telegram-desktop
      tutanota-desktop
      zed-editor
    ];
    shell = pkgs.fish;
  };

  zramSwap.enable = true;
}
