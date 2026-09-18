{
  pkgs,
  lib,
  ...
}: {
  # Basic packages for the system
  environment.systemPackages = with pkgs; [
    # Network
    tailscale
    tftp-hpa
  ];
}
