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

    # I HATE VS Code, but it is the only editor that has the Official Laravel extension
    # TODO: Implement a configuration similar to Zed and limit the extensions only to Laravel
    # IMPORTANT: DISABLE ALL TELEMETRY AND AI
    vscode-fhs 
  ];

  # TODO: Try to use the zed-editor-fhs version to improve the usage on NixOS
  programs.zed-editor = import ./zed/zedSettings.nix {
    inherit pkgs;
  };

  # programs.zed-editor = {
  #   enable = true;

  #   # LSPs
  #   extraPackages = with pkgs; [
  #     nil
  #     nixd
  #     nixpkgs-fmt
  #     package-version-server
  #     jsonnet-language-server
  #     phpactor
  #   ];

  #   extensions = [
  #     "nix"
  #     "nvim-nightfox"
  #     "charmed-icons"
  #     "laravel"
  #     "blade"
  #     "php"
  #     "phpcs"
  #     "comment"
  #   ];

  #   userSettings = {
  #     # Diagnostics and other useful information
  #     diagnostics.inline.enabled = true;
  #     code_lenss = "on";

  #     # Zed motion type
  #     helix_mode = true;

  #     # Sections organization
  #     project_panel.dock = "left";
  #     outline_panel.dock = "left";
  #     collaboration_panel.dock = "left";
  #     git_panel.dock = "left";
  #     terminal.dock = "right";

  #     # Themes (Editor and Icons)
  #     theme = {
  #       mode = "dark";
  #       light = "Ayu Light";
  #       dark = "Carbonfox - opaque";
  #     };
  #     icon_theme = "Base Charmed Icons";
  #     ui_font_size = 16;
  #     buffer_font_size = 15;
  #     buffer_font_family = "Iosevka Nerd Font Mono";

  #     # Save settings
  #     format_on_save = "off";
  #     autosave.after_delay.milliseconds = 500;

  #     # Disable Telemetry
  #     telemetry = {
  #       diagnostics = false;
  #       metrics = false;
  #     };

  #     # AI Settings for Code Completion
  #     edit_predictions = {
  #       mode = "subtle";
  #       ollama = {
  #         api_url = "http://<TAILSCALE_IP>:11434";
  #         model = "<MODEL>";
  #       };
  #       provider = "ollama";
  #     };

  #     # Settings required by extensions
  #     # Required by the Blade Extension
  #     file_types = {
  #       Blade = ["*.blade.php"];
  #     };

  #     # Required by the PHPCS Extension
  #     languages = {
  #       PHP = {
  #         language_servers = [
  #           "phpcs"
  #           "!phpactor"
  #         ];
  #       };
  #     };
  #   };
  # };

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
