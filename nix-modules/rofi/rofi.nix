{ pkgs, lib, config, ... }:
{
  options = {
    rofi.enable = lib.mkEnableOption "enables rofi browser";
  };

  config = {
    programs.rofi = {
        enable = config.rofi.enable;
        package = pkgs.rofi-wayland;
        theme = "/home/max/.dotfiles/nix-modules/rofi/spotlight-dark.rasi";
      };
  };
}
