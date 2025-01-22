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
  };

  outputs = { hyprpanel, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      mkConfiguration = isLaptop: home-manager.lib.homeManagerConfiguration {
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
        };
        modules = [ ./home.nix ];
      };
    in {
      homeConfigurations."pc" = mkConfiguration false;
      homeConfigurations."lap" = mkConfiguration true;
    };
}
