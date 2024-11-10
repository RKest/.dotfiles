{ pkgs, config, lib, ... }:
let
  alacrittyConfigSource = config.lib.file.mkOutOfStoreSymlink "/home/max/.dotfiles/nix-modules/alacritty/alacritty.toml";
in
{
  options = {
    alacritty.enable = lib.mkEnableOption "enables alacritty";
  };

  config = lib.mkIf config.alacritty.enable {
    home.packages = [
      pkgs.alacritty
    ];

    home.file."${config.xdg.configHome}/alacritty.toml".source = alacrittyConfigSource;
  };
}
