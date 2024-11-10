{ pkgs, lib, config, ... }:
{
  options = {
    rofi.enable = lib.mkEnableOption "enables rofi browser";
  };

  config = lib.mkIf config.rofi.enable {
    programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        theme = "/home/max/.dotfiles/nix-modules/rofi/spotlight-dark.rasi";
      };
  };
}
