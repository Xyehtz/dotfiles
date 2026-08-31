{ pkgs, inputs, ... }:

{
  imports = [
    ./modules/development/development.nix
    ./modules/desktop/desktopEnv.nix
    ./modules/gaming.nix
  ];

  # Disable systemd integration to prevent issues with UWSM
  wayland.windowManager.hyprland.systemd.enable = false;

  home.username = "alej-garz";
  home.homeDirectory = "/home/alej-garz";
  home.stateVersion = "26.11";
}
