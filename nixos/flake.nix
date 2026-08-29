{
  description = "";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kineticwe = {
      url = "gitlab:theblackdon/kineticwe";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }@inputs: let inherit (nixpkgs) lib;
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        nixos-hardware.nixosModules.asus-zephyrus-ga402 # TEST THIS
        home-manager.nixosModules.home-manager

        # Kineticwe
        inputs.kineticwe.nixosModules.default
        { programs.kineticwe.enable = true; }
        
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.alej-garz = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
