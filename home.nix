{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  home.username = "max";
  home.homeDirectory = "/home/max";
  home.stateVersion = "24.05"; # Don't change

  home.packages = [
    # Universal ternmial packages
    pkgs.neofetch
    pkgs.nixd
    pkgs.neovim
    pkgs.fzf
    pkgs.tmux
    pkgs.unzip
    pkgs.fd
    pkgs.ripgrep
    pkgs.tree
    pkgs.bat
    pkgs.gnumake
    pkgs.gcc
    pkgs.htop
    pkgs.nodejs
    pkgs.python3
    pkgs.basedpyright
    pkgs.zip
    pkgs.web-ext
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    # Gui packages
    pkgs.alacritty
    pkgs.nautilus
    pkgs.firefox
    pkgs.obsidian

    # Media packages
    pkgs.ytarchive
    pkgs.yt-dlp
    pkgs.mpv
  ];

  home.file = {
    "${config.xdg.configHome}/alacritty/alacritty.toml".source = config.lib.file.mkOutOfStoreSymlink "/home/max/.dotfiles/nix-modules/alacritty/alacritty.toml";
    "${config.xdg.configHome}/nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink "/home/max/.dotfiles/nvim";
        recursive = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    GTK_THEME = "Adwaita:dark";
  };

  programs.home-manager.enable = true;

  imports = [
    ./nix-modules/rofi/rofi.nix
    ./nix-modules/zsh/zsh.nix
    ./nix-modules/tmux.nix
    ./nix-modules/hyprland/hyprland.nix
    ./nix-modules/git.nix
  ];

  rofi.enable = true;
  zsh.enable = true;
  zoxide.enable = true;
  direnv.enable = true;
  tmux.enable = true;
  hyprland.enable = true;
  git.enable = true;
}
