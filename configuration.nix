{ pkgs, ... }:
{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
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

  hardware.nvidia.open = true;

  networking = {
    hostName = "vortex";
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
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
      enable = true;
      binfmt = true;
    };
    firefox.enable = true;
    fish.enable = true;
    gamemode.enable = true;
    gamescope.enable = true;
    git = {
      enable = true;
      config.user = {
        name = "F";
        email = "tkachuk@tuta.com";
      };
    };
    nh = {
      enable = true;
      flake = "/home/f/vortex";
      clean = {
        enable = true;
        extraArgs = "--keep 3 --keep-since 4d";
      };
    };
    ssh.extraConfig = "IdentityAgent ~/.bitwarden-ssh-agent.sock";
    starship.enable = true;
    steam.enable = true;
    virt-manager.enable = true;
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
    displayManager.cosmic-greeter.enable = true;
    desktopManager.cosmic.enable = true;
    flatpak.enable = true;
    fstrim.enable = true;
    fwupd.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    resolved.enable = true;
    xserver.videoDrivers = [ "nvidia" ];
  };

  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  system.stateVersion = "26.05";
  time.timeZone = "Europe/Copenhagen";
  zramSwap.enable = true;

  users.users.f = {
    isNormalUser = true;
    extraGroups = [
      "audio"
      "libvirtd"
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      bitwarden-desktop
      burpsuite
      peazip
      reaper
      signal-desktop
      spotify
      telegram-desktop
      tutanota-desktop
      wineWow64Packages.stable
      zed-editor
    ];
    shell = pkgs.fish;
  };

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        runAsRoot = false;
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };
}
