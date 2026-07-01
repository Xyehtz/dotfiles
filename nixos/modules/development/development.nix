{ config, pkgs, lib, ... }:

{
  imports = [
    ./zed/extraZedPackages.nix
  ];
  
  home.packages = with pkgs; [
    git

    # Editors
    helix

    # LSPs
    yaml-language-server # Nix
    ltex-ls # Markdown
    marksman # Markdown
    taplo # TOML
    codebook # Spellcheck
    typescript-language-server # TypeScript and JavaScript
    tailwindcss-language-server # Tailwind
    vscode-langservers-extracted # HTML and CSS
    superhtml # HTML
 ];

  # TODO: Try to use the zed-editor-fhs version to improve the usage on NixOS
  programs.zed-editor = import ./zed/zedSettings.nix {
    inherit pkgs;
  };

  # Other configurations
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
