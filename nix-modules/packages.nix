{ pkgs, config, lib, ... }:
let
  teminalUtils = [
    pkgs.neovide
    pkgs.neofetch
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
    pkgs.zip
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  lspPkgs = [
    pkgs.nixd
    pkgs.basedpyright
    pkgs.typescript-language-server
    pkgs.emmet-language-server
  ];

  guiPkgs = [
    pkgs.nautilus
    pkgs.firefox
    pkgs.obsidian
  ];

  mediaPkgs = [
    pkgs.playerctl
    pkgs.ytarchive
    pkgs.yt-dlp
    pkgs.mpv
  ];
in
{
  options = {
    terminalUtilsPkgs.enable = lib.mkEnableOption "enables universal terminal utils";
    guiPkgs.enable = lib.mkEnableOption "enables gui packages";
    mediaPkgs.enable = lib.mkEnableOption "enables media packages";
    lspPkgs.enable = lib.mkEnableOption "enables lsp packages";
  };

  config = {
    home.packages = lib.concatLists [
      (lib.optionals config.terminalUtilsPkgs.enable teminalUtils)
      (lib.optionals config.guiPkgs.enable guiPkgs)
      (lib.optionals config.mediaPkgs.enable mediaPkgs)
      (lib.optionals config.lspPkgs.enable lspPkgs)
    ];
  };
}
