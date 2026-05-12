{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.username = "alej-garz";
  home.homeDirectory = "/home/alej-garz";
  home.stateVersion = "25.11";

  # Enable Git
  programs.git.enable = true;

  # Configure Helix
  programs.helix = {
    enable = true;
    settings = {
      theme = "rasmus";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = false;
        formatter.command = "${lib.getExe pkgs.nixfmt}";
      }
      {
        name = "rust";
        auto-format = false;
        formatter.command = "${lib.getExe pkgs.rustfmt}";
      }
      {
        name = "astro";
        auto-format = false;
        formatter = {
          command = "bun";
          args = [
            "x"
            "prettier"
            "--stdin-filepath"
            "{path}"
            "--plugin"
            "prettier-plugin-astro"
          ];
        };
      }
      {
        name = "typescript";
        auto-format = false;
        formatter = {
          command = "bun";
          args = ["format" "--stdin-filepath" "{path}"];
        };
      }
    ];
  };

  xdg.configFile."zed/settings.json".source = config.lib.file.mkOutOfStoreSymlink "/home/alej-garz/Projects/dotfiles/zed/settings.json";
  xdg.configFile."ghostty/config.ghostty".source = config.lib.file.mkOutOfStoreSymlink "/home/alej-garz/Projects/dotfiles/ghostty/config.ghostty";

  # Add the LSP for Helix
  home.packages = with pkgs; [
    nil
    nixd
    rust-analyzer
    lldb

    # Web development related
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages."@astrojs/language-server"
    nodePackages.prettier
  ];
}
