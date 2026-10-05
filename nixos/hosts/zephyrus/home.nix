{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./modules/development/development.nix
    ./modules/desktop-env.nix
    ./modules/gaming.nix
    ./modules/nvf-config.nix
    ./modules/helix.nix

    # NVF
    inputs.nvf.homeManagerModules.default
  ];

  home.username = "alej-garz";
  home.homeDirectory = "/home/alej-garz";
  home.stateVersion = "26.11";
}
