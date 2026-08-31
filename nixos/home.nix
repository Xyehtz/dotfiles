{ config, pkgs, inputs, ... }:

{
  imports = [
    ./modules/development/development.nix
    ./modules/desktopEnv.nix
    ./modules/gaming.nix
    ./modules/desktopEnv.nix
  ];

  # Disable systemd integration to prevent issues with UWSM
  wayland.windowManager.hyprland.systemd.enable = false;

  home.username = "alej-garz";
  home.homeDirectory = "/home/alej-garz";
  home.stateVersion = "26.11";
}
