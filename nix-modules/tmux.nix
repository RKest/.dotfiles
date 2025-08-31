{
  pkgs,
  lib,
  config,
  ...
}: let
  minimalTmux = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "minimal-tmux";
    version = "main";
    src = pkgs.fetchFromGitHub {
      owner = "niksingh710";
      repo = "minimal-tmux-status";
      rev = "672b230313fa238e569c672eb30a0677982156bf";
      sha256 = "sha256-0PROCM7iirKywY4SYjVkAgUio+NxjsCM+4TdiXjcuaw=";
    };
    rtpFilePath = "minimal.tmux";
  };
in {
  options = {
    tmux.enable = lib.mkEnableOption "enables tmux";
  };

  config = {
    programs.tmux = {
      enable = config.tmux.enable;
      mouse = true;
      baseIndex = 1;
      escapeTime = 0;
      prefix = "C-b";
      historyLimit = 50000;
      plugins = [
        pkgs.tmuxPlugins.vim-tmux-navigator
        {
          plugin = minimalTmux;
          extraConfig = ''
            set -g @minimal-tmux-bg "#aaaaaa"
            set -g @minimal-tmux-indicator false
            set -g @minimal-tmux-justify "left"
            set -g @minimal-tmux-status-right-extra ""
            set -g @minimal-tmux-right false
          '';
        }
      ];
      extraConfig = ''
        set-option -g default-terminal "tmux-256color"
        set-option -g default-shell ${lib.getExe pkgs.nushell}
        set-option -g renumber-windows on

        bind -n M-H previous-window
        bind -n M-L next-window
      '';
    };
  };
}
