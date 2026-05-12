{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "asus-nb-wmi" "amdgpu" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.asusd = {
    enable = true;
    # enableUserService = true;
  };
  services.supergfxd.enable = true;

  # User account
  users.users.alej-garz = {
    isNormalUser = true;
    description = "Alejandro Garzon";
    extraGroups = [ "networkmanager" "wheel" "video" "input" ];
  };

  # Install Steam and Gamescope
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    helix
    git
    zed-editor
    xclip
    element-desktop
    fzf
    htop
    nvtopPackages.amd
    ghostty
    ryzenadj
    librewolf
    libsForQt5.qtstyleplugin-kvantum
    plasma-panel-colorizer
    rustc
    obsidian

    # Better Blur package from flake
    inputs.kwin-effects-better-blur-dx.packages.${pkgs.system}.default # For Wayland
    inputs.kwin-effects-better-blur-dx.packages.${pkgs.system}.x11     # For X11
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    kate
    konsole
    elisa
    khelpcenter
    okular
    plasma-browser-integration
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
  ];
  
  system.stateVersion = "25.11"; 
}
