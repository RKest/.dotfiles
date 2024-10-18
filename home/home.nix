{ config, pkgs, ... }:

{
  home.username = "max";
  home.homeDirectory = "/home/max";

  home.stateVersion = "24.05"; # Don't change

  home.packages = [
    pkgs.fzf
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
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
