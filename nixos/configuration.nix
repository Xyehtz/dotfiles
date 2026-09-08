{ inputs, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./auto-upgrade.nix
      ./modules/netbird-client.nix
    ];

  # Systemd Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # --------------------------------Asus G14 2022 Specific--------------------------------

  # ========Kernel and AMD GPU Driver settings=========
  boot.kernelParams = [
  	#"pcie_aspm=off"
  	# "consoleblank=0"
	  # "amdgpu.dcdebugmask=0x10"
	  # "amdgpu.sg_display=0"
	  # "acpi_backlight=vendor"
	  # "usbcore.quirks=0b05:19b6:k"
	  "amd_pstate=active"
  ];

  # boot.extraModprobeConfig = ''
  #   options amdgpu runpm=0
  # '';

  boot.kernelModules = [ "asus-nb-wmi" "amdgpu" ];

  # Set the governor for the laptop when in battery and charger
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "performance";
      turbo = "never";
    };

    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };

  services.power-profiles-daemon.enable = false;

  # Asus Linux
  services.asusd = {
	  enable = true;
  };

  # GNOME Keyring - Important in order to maintain access to Element Clients
  services.gnome.gnome-keyring.enable = true;

  # The power profiles daemon needs to be removed/disabled because otherwise
  # the auto-cpufreq service won't work because it will conflict with the power profiles
  #
  # services.power-profiles-daemon.enable = true;

  # A folder for asusd where multiple configurations are saved also needs to be created
  # systemd.tmpfiles.rules = [
  #   "d /etc/asusd 0755 root root -"
  # ];

  # ------------------------------End of Asus G14 Specific-------------------------------

  hardware.enableRedistributableFirmware = true;
  hardware.graphics = {
  	enable = true;
  	enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Undervolt Service
  systemd.services.cpu-undervolt = {
    description = "CPU Undervolt service";
    wantedBy = [ "multi-user.target" ];
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

  # KDE Plasma - Disabled as Hyprland is being tested
  # services = {
  #   desktopManager.plasma6.enable = true;
  #   displayManager.plasma-login-manager.enable = true;
  # };

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

  # Basic packages for the system
  environment.systemPackages = with pkgs; [
    # Terminal
    kitty

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
		tailscale

		# Other
		fuzzel
		swaybg
		xwayland-satellite
    nix-search-cli

    # SSH
    sshfs

		# Noctalia
		inputs.noctalia.packages.${system}.default
  ];

  fonts.packages = with pkgs; [
    monaspace
 ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
    "steam-original"
    "steam-run"
    "obsidian"
    "rpcs3"
  ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05"; # Did you read the comment?
}

# NOTE
# This really needs to be cleaned up into multiple modules holy shit
