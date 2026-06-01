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
  boot.kernelParams = [
  	"pcie_aspm=off"
  	"consoleblank=0"
	  "amdgpu.dcdebugmask=0x10"
	  # "amdgpu.sg_display=0"
	  "acpi_backlight=vendor"
	  "usbcore.quirks=0b05:19b6:k"
  ];
  boot.kernelModules = [ "asus-nb-wmi" "amdgpu" ];

  boot.extraModprobeConfig = ''
	  options amdgpu runpm=0
  '';

  powerManagement.cpuFreqGovernor = "performance";

  # Asus Linux
  services.asusd = {
	  enable = true;
  };

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
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.qtile.enable = true;
  };

  # ly
  services.displayManager.ly.enable = true;

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
 	    "input"
 	  ];
  };

  programs.steam = {
    enable = true;
  };

  # Basic packages for the system
  environment.systemPackages = with pkgs; [
	  helix # Main text editor
	  git
	  ghostty
	  rofi
	  btop
	  librewolf
	  element-desktop
	  gamescope
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
    "steam-original"
    "steam-run"
  ];

  system.stateVersion = "26.05"; # Did you read the comment?

}

