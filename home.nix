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
    ];
  };

  # Add the LSP
  home.packages = with pkgs; [
    nil
    nixd
  ];
}
