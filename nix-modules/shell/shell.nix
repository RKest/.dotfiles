{ pkgs, lib, config, ... }:
{
  options = {
    zoxide.enable = lib.mkEnableOption "enables zoxide";
    direnv.enable = lib.mkEnableOption "enables direnv";
    nushell.enable = lib.mkEnableOption "enables nushell";
    carapace.enable = lib.mkEnableOption "enables carapace";
  };

  config = {
    home.file."${config.xdg.configHome}/nushell/config.nu" = {
      enable = config.nushell.enable;
      source = config.lib.file.mkOutOfStoreSymlink "/home/max/.dotfiles/nix-modules/shell/config.nu";
      recursive = true;
    };

    programs.direnv = {
      enable = config.direnv.enable;
      nix-direnv.enable = true;
    };

    programs.zoxide = {
      enable = config.zoxide.enable;
      options = [ "--cmd cd" ];
    };

    programs.nushell = {
      enable = config.nushell.enable;
    };

    programs.carapace = {
      enable = config.carapace.enable;
    };
  };
}

