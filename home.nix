{ config, pkgs, ... }:
let minimalTmux = pkgs.tmuxPlugins.mkTmuxPlugin {
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
in
{
  home.username = "max";
  home.homeDirectory = "/home/max";

  home.stateVersion = "24.05"; # Don't change

  home.packages = [
    pkgs.fzf
    pkgs.ytarchive
    pkgs.tmux
    pkgs.wl-clipboard
    pkgs.gnumake
    pkgs.clang
    pkgs.clang-tools
    pkgs.nixd
    pkgs.meslo-lgs-nf
    pkgs.swaybg
    pkgs.hyprpicker
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  home.file = {
    "${config.xdg.configHome}/hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink "/home/max/.dotfiles/hyprland.conf";
    "${config.xdg.configHome}/alacritty/alacritty.toml".source = config.lib.file.mkOutOfStoreSymlink "/home/max/.dotfiles/alacritty.toml";
    "${config.xdg.configHome}/waybar" = {
    	source = config.lib.file.mkOutOfStoreSymlink "/home/max/.dotfiles/waybar";
	recursive = true;
    };
    "${config.xdg.configHome}/nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink "/home/max/.dotfiles/nvim";
        recursive = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    NIX_PATH = "~/.nix-defexpr/channels_root/nixos/nixpkgs";
  };

  programs.home-manager.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

    shellAliases = {
      ll = "ls -l";
      c = "clear";
    };
    initExtra = ''
      if [ -n "''${commands[fzf-share]}" ]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
      fi

      source "/home/max/.dotfiles/zsh/.p10k.zsh"
    '';

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
  };


  programs.tmux = {
    enable = true;
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
      set-option -g renumber-windows on

      bind -n S-Left  previous-window
      bind -n S-Right next-window
      bind -n M-H previous-window
      bind -n M-L next-window
    '';
  };
}
