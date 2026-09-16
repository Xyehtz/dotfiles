{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./modules/development/development.nix
    ./modules/desktopEnv.nix
    ./modules/gaming.nix
    ./modules/nvf-config.nix

    # NVF
    inputs.nvf.homeManagerModules.default
  ];

  home.username = "alej-garz";
  home.homeDirectory = "/home/alej-garz";
  home.stateVersion = "26.11";
}
