{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./auto-upgrade.nix
    ./services/matrix.nix
    ./services/pihole.nix
    ./services/unbound.nix
    ./services/tailscale.nix
    ./services/tftp.nix
    ./services/matrix-caddy.nix
    ./services/caremonda.nix
    ../../general/bootloader.nix
    ../../general/garbage-collection.nix
    ../../general/ram-compression.nix
    ./programs.nix
    ./modules/minecraft-server/server.nix

    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  # Overlay for the Minecraft Server
  nixpkgs.overlays = [
    inputs.nix-minecraft.overlay
  ];

  networking.hostName = "nixos-homelab";

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  time.timeZone = "America/Toronto";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mini-homelab = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    wget
    helix
    git
    btop
  ];

  services.openssh = {
    enable = true;
  };
  services.nginx.enable = true;

  security.acme = {
    acceptTerms = true;
    defaults.email = "admin@stryxredact.net";
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "26.05"; # Did you read the comment?
}
