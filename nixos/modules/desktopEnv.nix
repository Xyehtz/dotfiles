{ pkgs, inputs, config, ... }:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
  ];

  # File Manager
  programs.yazi.enable = true;

  # Other packcages
  home.packages = with pkgs; [
    rofi
  ];

  # Sync configs
  xdg.configFile."niri/config.kdl" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/alej-garz/Projects/dotfiles/niri/config.kdl";
    recursive = true;
  };
}
