{
  description = "Flake for the Matix Homeserver";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-minecraft,
  }: {
    nixosConfigurations.mini-homelab = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
      ];
    };
  };
}
