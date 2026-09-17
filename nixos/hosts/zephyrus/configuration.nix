{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./auto-upgrade.nix
    ../general/bootloader.nix
    ../general/bluetooth.nix
    ../general/garbage-collection.nix
    ../general/ram-compression.nix
    ../general/sound.nix
    ./services/core-services.nix
    ./services/tailscale.nix
    ./programs.nix
  ];

  # ========Kernel and AMD GPU Driver settings=========
  boot = {
    kernelParams = [
      "amd_pstate=active"
    ];
    kernelModules = [
      "asus-nb-wmi"
    ];
  };

  # AMD Drivers
  hardware = {
    enableRedistributableFirmware = true;
    amdgpu.initrd.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
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

  # Network
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # Timezone
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

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

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
  };

  environment.systemPackages = with pkgs; [
    # Noctalia
    inputs.noctalia.packages.${system}.default
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
