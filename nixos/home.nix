{ config, pkgs, inputs, ... }:

{
  imports = [
    ./modules/development/development.nix
    ./modules/desktopEnv.nix
    inputs.kineticwe.nixosModules.default
  ];

  home.username = "alej-garz";
  home.homeDirectory = "/home/alej-garz";
  home.stateVersion = "25.11";
}
