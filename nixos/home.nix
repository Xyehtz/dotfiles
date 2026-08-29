{ config, pkgs, inputs, ... }:

{
  imports = [
    ./modules/development/development.nix
    ./modules/desktopEnv.nix
    ./modules/gaming.nix
  ];

  home.username = "alej-garz";
  home.homeDirectory = "/home/alej-garz";
  home.stateVersion = "26.11";
}
