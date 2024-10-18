{ config, pkgs, ... }:

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
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  home.file = {
    "${config.xdg.configHome}/hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink "/home/max/.dotfiles/hyprland.conf";
    "${config.xdg.configHome}/alacritty/alacritty.toml".source = config.lib.file.mkOutOfStoreSymlink "/home/max/.dotfiles/alacritty.toml";
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "/home/max/.dotfiles/zsh/.zshrc";
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
  };

  programs.home-manager.enable = true;
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    prefix = "C-b";
    plugins = [
      pkgs.tmuxPlugins.vim-tmux-navigator
      pkgs.tmuxPlugins.onedark-theme
    ];
    extraConfig = ''
      set -g mouse on
      set -s escape-time 0

      set-option -g history-limit 50000
      set-option -g renumber-windows on

      bind -n S-Left  previous-window
      bind -n S-Right next-window
      bind -n M-H previous-window
      bind -n M-L next-window
    '';
  };
}
