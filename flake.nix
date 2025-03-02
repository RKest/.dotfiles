{
  description = "Home Manager configuration of max";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpanel = {
      url = "github:jas-singhfsu/hyprpanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    hyprpanel,
    nixpkgs,
    home-manager,
    zen-browser,
    ...
  }: let
    system = "x86_64-linux";
    mkConfiguration = isLaptop:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            hyprpanel.overlay
          ];
        };
        extraSpecialArgs = {
          inherit system;
          inherit hyprpanel;
          inherit isLaptop;
          inherit zen-browser;
        };
        modules = [./home.nix];
      };
  in {
    homeConfigurations."pc" = mkConfiguration false;
    homeConfigurations."lap" = mkConfiguration true;
  };
}
