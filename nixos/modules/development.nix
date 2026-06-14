{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    git

    # Editors
    zed-editor
    helix

    # LSPs
    yaml-language-server # Nix
    nil # Nix
    nixd # Nix
    nixpkgs-fmt # Nix formatter
    ltex-ls # Markdown
    marksman # Markdown
    taplo # TOML
    codebook # Spellcheck
    phpactor # PHP
    typescript-language-server # TypeScript and JavaScript
    tailwindcss-language-server # Tailwind
    vscode-langservers-extracted # HTML and CSS
    superhtml # HTML
  ];

  xdg.configFile."helix" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/alej-garz/Projects/dotfiles/helix/";
    recursive = true;
  };

  # Doing the configurations of Zed this way doens't really work, it is better to put the configurations via Home Manager
  # TODO - Change this to the actual Zed Home Manager settings
  xdg.configFile."zed" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/alej-garz/Projects/dotfiles/zed";
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
