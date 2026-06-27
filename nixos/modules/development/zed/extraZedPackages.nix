{ pkgs, ... }:

{
  # The LSPs used by Zed
  home.packages = with pkgs; [
    nil
    nixd
    nixpkgs-fmt
    package-version-server
    jsonnet-language-server
    phpactor
    codebook
  ];
}