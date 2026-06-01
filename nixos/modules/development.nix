{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    helix
    git
  ];

  xdg.configFile."helix" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/alej-garz/Projects/dotfiles/helix/";
    recursive = true;
  };

  xdg.configFile."ghostty" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/alej-garz/Projects/dotfiles/ghostty";
    recursive = true;
  };

  xdg.configFile."fish" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/alej-garz/Projects/dotfiles/fish";
    recursive = true;
  };
}
