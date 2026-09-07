{ pkgs, inputs, config, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  # File Manager
  programs.yazi.enable = true;

  # Other packcages
  home.packages = with pkgs; [

  ];

  programs.noctalia = {
    enable = true;
  };

  # Sync configs
  xdg.configFile."niri/config.kdl" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/alej-garz/Projects/dotfiles/niri/config.kdl";
    recursive = true;
  };

  xdg.configFile."quickshell/noctalia/settings.json" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/alej-garz/Projects/dotfiles/noctalia/settings.json";
  };
}
