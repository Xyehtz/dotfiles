{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Systemd Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # --------------------------------Asus G14 2022 Specific--------------------------------

  # === === === Kernel and AMD GPU Driver settings === === ===
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

  # === === === === === === === === === === === === === === ==

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
  
  # Asus Linux
  services.asusd = {
	  enable = true;
  };
  services.supergfxd.enable = true;

  # The power profiles daemon needs to be removed/disabled because otherwise
  # the auto-cpufreq service won't work because it will conflict with the power profiles
  # 
  # services.power-profiles-daemon.enable = true;
  
  # A folder for asusd where multiple configurations are saved also needs to be created
  systemd.tmpfiles.rules = [
    "d /etc/asusd 0755 root root -"
  ];

  # ------------------------------End of Asus G14 Specific-------------------------------

  hardware.enableRedistributableFirmware = true;
  hardware.graphics = {
  	enable = true;
  	enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Network
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  # I3
  # services.xserver = {
  #   enable = true;
  #   autoRepeatDelay = 200;
  #   autoRepeatInterval = 35;
  #   windowManager.qtile.enable = true;
  # };

  programs.mango.enable = true;

  # ly
  services.displayManager = {
    ly.enable = true;
    defaultSession = "mango";
  };

  # Enable sound.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
	  enable = true;
  	pulse.enable = true;
	  alsa.enable = true;
	  alsa.support32Bit = true;
  };

  # User account definition
  users.users.alej-garz = {
	  isNormalUser = true;
	  description = "Alej-Garz";
 	  extraGroups = [
 	    "networkmanager"
 	    "wheel"
 	    "video"
 	  ];
 	  shell = pkgs.fish; # Fish is the default shell
  };

  # Enable Fish and also keep the same shell whe starting Nix Develop
  programs.fish.enable = true;

  programs.steam = {
    enable = true;
  };

  # Basic packages for the system
  environment.systemPackages = with pkgs; [
	  ghostty
	  rofi
	  btop
	  librewolf
	  element-desktop
	  gamescope
	  nvtopPackages.amd
	  fastfetch
	  dunst
	  ryzenadj
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
    "steam-original"
    "steam-run"
    "obsidian"
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05"; # Did you read the comment?
}

