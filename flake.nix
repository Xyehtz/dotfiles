{
  description = "Dotfiles environment configuration";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        yaml-language-server
        nil
        nixpkgs-fmt
        rustc
        cargo
      ];

      shellHook = ''
        export SHELL=${pkgs.fish}/bin/fish
        exec ${pkgs.fish}/bin/fish

        cargo install taplo-cli --locked --features lsp
      '';
    };
  };
}
