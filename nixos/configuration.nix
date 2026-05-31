{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_6_12;

  boot.kernelParams = [
  	"pcie_aspm=off"
  	"consoleblank=0"
	  "amdgpu.dcdebugmask=0x10"
#	  "amdgpu.sg_display=0"
	  "acpi_backlight=vendor"
	  "usbcore.quirks=0b05:19b6:k"
  ];

  boot.kernelModules = [ "asus-nb-wmi" "amdgpu" ];
  boot.extraModprobeConfig = ''
	options amdgpu runpm=0
  '';

  powerManagement.cpuFreqGovernor = "performance";

  hardware.enableRedistributableFirmware = true;
  hardware.graphics = {
	enable = true;
	enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Configure network connections interactively with nmcli or nmtui.
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Set your time zone.
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

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
	enable = true;
  	pulse.enable = true;
	alsa.enable = true;
	alsa.support32Bit = true;
  };

  # Asus Linux
  services.asusd = {
	  enable = true;
  };

  systemd.tmpfiles.rules = [
    "d /etc/asusd 0755 root root -"
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alej-garz = {
	isNormalUser = true;
	description = "Alej-Garz";
 	extraGroups = [ "networkmanager" "wheel" "video" "input" ]; # Enable ‘sudo’ for the user.
  };

  programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
 	vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
	helix
	git
	ghostty
	rofi
	btop
  ];

  system.stateVersion = "26.05"; # Did you read the comment?

}

