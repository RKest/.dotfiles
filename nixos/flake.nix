{
  description = "System configuration nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
  let 
    lib = inputs.nixpkgs.lib;
  in {
    nixosConfigurations.maxlap = lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [ 
	./lap-hardware-configuration.nix
        ./configuration.nix 
	inputs.home-manager.nixosModules.default
      ];
    };

    nixosConfigurations.maxpc = lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [ 
	./pc-hardware-configuration.nix
        ./configuration.nix 
	inputs.home-manager.nixosModules.default
      ];
    };
  };
}
