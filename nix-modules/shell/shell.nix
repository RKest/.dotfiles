{ pkgs, lib, config, ... }:
{
  options = {
    zoxide.enable = lib.mkEnableOption "enables zoxide";
    direnv.enable = lib.mkEnableOption "enables direnv";
    nushell.enable = lib.mkEnableOption "enables nushell";
  };

  config = {
    programs.direnv = {
      enable = config.direnv.enable;
      enableNushellIntegration = config.nushell.enable;
      nix-direnv.enable = true;
    };

    programs.zoxide = {
      enable = config.zoxide.enable;
      enableNushellIntegration = config.nushell.enable;
      options = [ "--cmd cd" ];
    };

    programs.nushell = {
      enable = config.nushell.enable;
      configFile.source = ./config.nu;
    };
  };
}

