{
  description = "System configuration nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = inputs:
  let 
    lib = inputs.nixpkgs.lib;
  in {
    nixosConfigurations.maxlap = lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [ 
	./hardware/lap.nix
        ./configuration.nix 
      ];
    };

    nixosConfigurations.maxpc = lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [ 
	./hardware/pc.nix
        ./configuration.nix 
      ];
    };
  };
}
