{ pkgs, ... }:
{
  # ── Boot ────────────────────────────────────────────────────────────────
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 1;

      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        consoleMode = "max";
        editor = false;
      };
    };

    kernelParams = [ "nvidia-drm.fbdev=1" ];
    kernel.sysctl."vm.max_map_count" = 2147483642;
  };

  # ── Nix ─────────────────────────────────────────────────────────────────
  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  nixpkgs.config.allowUnfree = true;

  # ── Networking ──────────────────────────────────────────────────────────
  networking = {
    hostName = "vortex";

    firewall.enable = true;

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";

      wifi = {
        backend = "iwd";
        powersave = false;
      };
    };
  };

  # ── Hardware ─────────────────────────────────────────────────
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      settings = false;
      modesetting.enable = true;
      open = true;
      powerManagement.enable = true;
    };
  };

  # ── System ───────────────────────────────────────────────────────
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  time.timeZone = "Europe/Copenhagen";
  zramSwap.enable = true;
  system.stateVersion = "26.05";

  # ── Security ────────────────────────────────────────────────────────────
  security = {
    sudo-rs.enable = true;
    rtkit.enable = true;
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
  };

  # ── Users ───────────────────────────────────────────────────────────────
  users.users.f = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "audio"
    ];

    packages = with pkgs; [
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
      zed-editor
    ];
  };

  # ── Environment ─────────────────────────────────────────────────────────
  environment = {
    systemPackages = with pkgs; [
      xwayland-satellite
      bat
      eza
      fd
      ripgrep
    ];

    sessionVariables = {
      STEAM_RUNTIME_PREFER_HOST_LIBRARIES = "0";
      WINE_FULLSCREEN_FSR = "1";
      WINE_FULLSCREEN_FSR_STRENGTH = "2";
    };
  };

  # ── Programs ────────────────────────────────────────────────────────────
  programs = {
    appimage = {
      enable = true;
      binfmt = true;
    };

    niri.enable = true;
    firefox.enable = true;
    fish.enable = true;
    starship.enable = true;
    zoxide.enable = true;
    virt-manager.enable = true;

    git = {
      enable = true;
      config.user = {
        email = "tkachuk@tuta.com";
        name = "F";
      };
    };

    ssh.extraConfig = ''
      Host *
        IdentityAgent ~/.bitwarden-ssh-agent.sock
    '';

    nh = {
      enable = true;
      flake = "/etc/nixos";

      clean = {
        enable = true;
        extraArgs = "--keep 3 --keep-since 4d";
      };
    };

    gamemode = {
      enable = true;
      settings.general = {
        renice = -10;
        softrealtime = "auto";
      };
    };

    gamescope = {
      enable = true;
      capSysNice = true;
    };

    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };

  # ── Services ────────────────────────────────────────────────────────────
  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
    flatpak.enable = true;
    resolved.enable = true;
    fstrim.enable = true;
    fwupd.enable = true;

    earlyoom = {
      enable = true;
      freeMemThreshold = 5;
      freeSwapThreshold = 10;
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
    };

    xserver.videoDrivers = [ "nvidia" ];
  };

  # ── Virtualisation ──────────────────────────────────────────────────────
  virtualisation = {
    spiceUSBRedirection.enable = true;

    libvirtd = {
      enable = true;

      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = false;
        swtpm.enable = true;
      };
    };
  };
}
