{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    helix
    git

    # LSPs
    yaml-language-server
    nil
    nixpkgs-fmt
    ltex-ls
    marksman
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
