{ config, lib, ... }:
{
  options = {
    git.enable = lib.mkEnableOption "enables git";
  };

  config = {
    programs.git = {
      enable = config.git.enable ;
      userName = "RKest";
      userEmail = "max.ind@o2.pl";
      extraConfig = {
        push.autoSetupRemote = true;
        init.defaultBranch = "main";
      };
    };
  };
}
