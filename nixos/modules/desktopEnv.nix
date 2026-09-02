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
  xdg.configFile."hypr/hyprland.lua" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/alej-garz/Projects/dotfiles/hyprland/hyprland.lua";
    recursive = true;
  };
  xdg.configFile."waybar" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/alej-garz/Projects/dotfiles/waybar";
    recursive = true;
  };
}
