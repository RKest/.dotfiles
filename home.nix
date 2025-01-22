{ hyprpanel, config, ... }:
{
  nixpkgs.config.allowUnfree = true;
  home.username = "max";
  home.homeDirectory = "/home/max";
  home.stateVersion = "24.05"; # Don't change

  home.file."${config.xdg.configHome}/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/max/.dotfiles/nvim";
    recursive = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    GTK_THEME = "Adwaita:dark";
  };

  programs.home-manager.enable = true;

  imports = [
    ./nix-modules/packages.nix
    ./nix-modules/tmux.nix
    ./nix-modules/git.nix
    ./nix-modules/rofi/rofi.nix
    ./nix-modules/shell/shell.nix
    ./nix-modules/hyprland/hyprland.nix
    ./nix-modules/alacritty/alacritty.nix
    hyprpanel.homeManagerModules.hyprpanel
  ];

  terminalUtilsPkgs.enable = true;
  guiPkgs.enable = true;
  mediaPkgs.enable = true;
  lspPkgs.enable = true;

  rofi.enable = true;
  tmux.enable = true;
  hyprland.enable = true;
  git.enable = true;
  alacritty.enable = true;

  zoxide.enable = true;
  direnv.enable = true;
  nushell.enable = true;
  carapace.enable = true;
}
