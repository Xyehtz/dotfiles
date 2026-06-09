{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    helix
    git

    # LSPs
    yaml-language-server         # Nix
    nil                          # Nix
    nixpkgs-fmt                  # Nix formatter
    ltex-ls                      # Markdown
    marksman                     # Markdown
    taplo                        # TOML
    codebook                     # Spellcheck
    phpactor                     # PHP
    typescript-language-server   # TypeScript and JavaScript
    tailwindcss-language-server     # Tailwind
    vscode-langservers-extracted # HTML and CSS
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
