{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./auto-upgrade.nix
    ./modules/netbird-client.nix
    ./fonts.nix
    ../general/bootloader.nix
    ./services/core-services.nix
  ];

  # ========Kernel and AMD GPU Driver settings=========
  boot.kernelParams = [
    "amd_pstate=active"
  ];

  boot.kernelModules = [
    "asus-nb-wmi"
    "amdgpu"
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Undervolt Service
  systemd.services.cpu-undervolt = {
    description = "CPU Undervolt service";
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.ryzenadj}/bin/ryzenadj --set-coall=10";
    };
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

  # RAM Compression
  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "lz4";
    memoryPercent = 50;
  };

  # Network
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  # Niri
  programs.niri.enable = true;

  # Enable sound.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true; # Show the battery of connected devices
        FastConnectable = false; # The power consumptions trade-off is not worth it
      };

      Policy = {
        AutoEnable = true;
      };
    };
  };

  # User account definition
  users.users.alej-garz = {
    isNormalUser = true;
    description = "Alej-Garz";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "corectrl"
    ];
    shell = pkgs.fish; # Fish is the default shell
  };

  # Enable Fish and also keep the same shell whe starting Nix Develop
  programs.fish.enable = true;

  programs.steam = {
    enable = true;
  };

  # CoreCtrl used for GPU undervolting
  programs.corectrl = {
    enable = true;
    gpuOverclock.enable = true;
    gpuOverclock.ppfeaturemask = "0xffffffff";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Enable this for unpatched binaries in order to prevent issues. Specially with Zed extensions
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
    ];
  };

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
  };

  # Basic packages for the system
  environment.systemPackages = with pkgs; [
    # Terminal
    ghostty

    # Terminal applications
    nvtopPackages.amd
    btop
    fastfetch
    ryzenadj
    yt-dlp
    corectrl

    # Browser
    librewolf

    # Matrix clients
    element-desktop

    # Notes
    obsidian

    # Email Client
    thunderbird

    # VPN and File Sharing
    localsend

    # Other
    fuzzel
    swaybg
    xwayland-satellite
    nix-search-cli

    # SSH
    sshfs

    # Noctalia
    inputs.noctalia.packages.${system}.default

    # API Tester
    bruno

    # School/College
    onlyoffice-desktopeditors
    teams-for-linux
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"
      "steam-original"
      "steam-run"
      "obsidian"
      "rpcs3"
    ];

  # Enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "26.05"; # Did you read the comment?
}
# NOTE
# This really needs to be cleaned up into multiple modules holy shit
