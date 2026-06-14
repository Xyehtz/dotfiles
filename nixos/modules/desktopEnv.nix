{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    
  ];

  xdg.configFile."mango" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/alej-garz/Projects/dotfiles/mango";
    recursive = true;
  };
}
