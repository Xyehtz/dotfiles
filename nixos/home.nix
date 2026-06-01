{ config, pkgs, ... }:

{
  imports = [
    ./modules/development.nix
  ];

  home.username = "alej-garz";
  home.homeDirectory = "/home/alej-garz";
  home.stateVersion = "25.11";
}
