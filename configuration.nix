{ pkgs, ... }:
{
  # ── Boot ────────────────────────────────────────────────────────────────
  boot = {
    initrd.supportedFilesystems = [ "btrfs" ];

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        consoleMode = "max";
        editor = false;
      };

      timeout = 1;
    };
  };

  # ── Environment ─────────────────────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    bat
    eza
    fd
    ripgrep
    xwayland-satellite
    yazi
  ];

  # ── Hardware ────────────────────────────────────────────────────────────
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      open = true;
    };
  };

  # ── Networking ──────────────────────────────────────────────────────────
  networking = {
    hostName = "vortex";

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.backend = "iwd";
    };
  };

  # ── Nix ─────────────────────────────────────────────────────────────────
  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  nixpkgs.config.allowUnfree = true;

  # ── Programs ────────────────────────────────────────────────────────────
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
        email = "tkachuk@tuta.com";
        name = "F";
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

    niri.enable = true;

    ssh.extraConfig = "IdentityAgent ~/.bitwarden-ssh-agent.sock";

    starship.enable = true;
    steam.enable = true;
    virt-manager.enable = true;
    zoxide.enable = true;
  };

  # ── Security ────────────────────────────────────────────────────────────
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

  # ── Services ────────────────────────────────────────────────────────────
  services = {
    displayManager.lemurs.enable = true;

    earlyoom = {
      enable = true;
      freeMemThreshold = 5;
      freeSwapThreshold = 10;
    };

    flatpak.enable = true;
    fstrim.enable = true;
    fwupd.enable = true;

    pipewire = {
      enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };

      jack.enable = true;
      pulse.enable = true;
    };

    resolved.enable = true;
    xserver.videoDrivers = [ "nvidia" ];
  };

  # ── System ──────────────────────────────────────────────────────────────
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  system.stateVersion = "26.05";
  time.timeZone = "Europe/Copenhagen";
  zramSwap.enable = true;

  # ── Users ───────────────────────────────────────────────────────────────
  users.users.f = {
    isNormalUser = true;

    extraGroups = [
      "audio"
      "libvirtd"
      "networkmanager"
      "wheel"
    ];

    packages = with pkgs; [
      alacritty
      bitwarden-desktop
      burpsuite
      elephant
      fuzzel
      peazip
      reaper
      signal-desktop
      spotify
      telegram-desktop
      tutanota-desktop
      walker
      wineWow64Packages.stable
      zed-editor
    ];

    shell = pkgs.fish;
  };

  # ── Virtualisation ──────────────────────────────────────────────────────
  virtualisation = {
    libvirtd = {
      enable = true;

      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = false;
        swtpm.enable = true;
      };
    };

    spiceUSBRedirection.enable = true;
  };
}
