{ pkgs, config, lib, ... }:
let
  teminalUtils = [
    pkgs.ueberzugpp
    pkgs.ghostty
    pkgs.vial
    pkgs.neovim
    pkgs.ffmpeg
    pkgs.wget
    pkgs.dotnet-sdk
    pkgs.fsharp
    pkgs.btop
    pkgs.neovide
    pkgs.neofetch
    pkgs.difftastic
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
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.typst
    pkgs.websocat
  ];

  lspPkgs = [
    pkgs.tinymist
    pkgs.lua-language-server
    pkgs.clang-tools
    pkgs.nixd
    pkgs.basedpyright
    pkgs.typescript-language-server
    pkgs.emmet-language-server
    pkgs.tailwindcss-language-server
    pkgs.htmx-lsp
  ];

  guiPkgs = [
    pkgs.qutebrowser
    pkgs.zathura
    pkgs.nautilus
    pkgs.brave
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
