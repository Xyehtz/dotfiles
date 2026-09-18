{
  pkgs,
  lib,
  ...
}: {
  programs.fish.enable = true;

  # Basic packages for the system
  environment.systemPackages = with pkgs; [
    # Network
    tailscale
  ];
}
