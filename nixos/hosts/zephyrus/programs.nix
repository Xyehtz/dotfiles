{
  pkgs,
  lib,
  ...
}: {
  programs = {
    niri.enable = true;
    fish.enable = true;
    steam.enable = true;

    # CoreCtrl used for GPU undervolting
    corectrl = {
      enable = true;
      gpuOverclock.enable = true;
      gpuOverclock.ppfeaturemask = "0xffffffff";
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  # Basic packages for the system
  environment.systemPackages = with pkgs; [
    # Terminal
    ghostty
    tmux

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
    xwayland-satellite
    nix-search-cli
    tailscale

    # SSH
    sshfs

    # API Tester
    bruno

    # School/College
    onlyoffice-desktopeditors
    teams-for-linux
    tigervnc
    swift
    sourcekit-lsp
    stirling-pdf-desktop
  ];

  # Allowed unfree software
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"
      "steam-original"
      "steam-run"
      "obsidian"
      "rpcs3"
    ];
}
