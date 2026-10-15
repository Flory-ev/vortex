{ pkgs, ... }:
{
  imports = [
    ./modules/gaming.nix
    ./modules/virtualization.nix
  ];

  boot = {
    initrd.systemd.enable = true;
    kernel.sysctl = {
      "vm.swappiness" = 10;
      "kernel.dmesg_restrict" = true;
      "kernel.kptr_restrict" = 2;
      "kernel.unprivileged_bpf_disabled" = 1;
    };
    kernelParams = [
      "quiet"
      "amd_pstate=active"
      "nvidia-drm.fbdev=1"
    ];
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 5;
      systemd-boot = {
        configurationLimit = 10;
        consoleMode = "max";
        editor = false;
        enable = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    nixfmt
  ];

  fonts.packages = with pkgs; [
    font-awesome
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Experimental = true;
    };

    cpu.amd.updateMicrocode = true;
    graphics.enable = true;

    nvidia = {
      modesetting.enable = true;
      open = true;
      powerManagement.enable = true;
    };
  };

  networking = {
    hostName = "vortex";
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi = {
        backend = "iwd";
        powersave = false;
      };
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
    wireless.iwd = {
      enable = true;
      settings = {
        General.RoamRetryInterval = 15;
        Rank.BandModifier5Ghz = 5.0;
      };
    };
  };

  programs = {
    appimage = {
      enable = true;
      binfmt = true;
    };
    fish.enable = true;
    nh = {
      enable = true;
      flake = "/etc/nixos";
      clean = {
        enable = true;
        extraArgs = "--keep 3 --keep-since 4d";
      };
    };
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
        zlib
      ];
    };
  };

  security = {
    rtkit.enable = true;
    sudo-rs.enable = true;
  };

  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
    earlyoom = {
      enable = true;
      freeMemThreshold = 5;
      freeSwapThreshold = 10;
    };
    flatpak.enable = true;
    fstrim.enable = true;
    fwupd.enable = true;
    mullvad-vpn.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa.enable = true;
    };
    resolved.enable = true;
    xserver.videoDrivers = [ "nvidia" ];
  };

  time.timeZone = "Europe/Copenhagen";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ru_RU.UTF-8/UTF-8"
  ];
  console.keyMap = "us";

  powerManagement.cpuFreqGovernor = "performance";
  zramSwap.enable = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [ "https://nix-community.cachix.org" ];
    trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dde0enMB6oXQ5yOtIyBTD6jLMOx3SoLDA=" ];
  };
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.05";

  users.users.f = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "audio"
      "networkmanager"
      "wheel"
    ];
  };
}
