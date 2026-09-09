{ pkgs, ... }:

let
  extensions = import ./extensions.nix;
  settings = import ./userSettings.nix;
in {
  enable = true;
  extensions = extensions;
  userSettings = settings;
}