{
  description = "";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # DankMaterialShell
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # dgop package for DankMaterialShell
    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let inherit (nixpkgs) lib;
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.alej-garz = import ./home.nix;
            backupFileExtension = "backup";
            extraSpecialArgs = { inherit inputs; };
          };
        }
      ];
    };
  };
}
