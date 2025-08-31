{
  zen-browser,
  pkgs,
  config,
  lib,
  quickshell,
  nix-steel,
  ...
}: let
  teminalUtils = [
    pkgs.gdb
    pkgs.cakelisp
    pkgs.helix
    pkgs.cmake
    pkgs.google-cloud-sdk
    pkgs.go
    pkgs.github-cli
    pkgs.google-drive-ocamlfuse
    pkgs.nh
    pkgs.lazygit
    pkgs.cloc
    pkgs.rustup
    pkgs.razergenie
    pkgs.usbutils
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
    pkgs.nerd-fonts.roboto-mono
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.typst
    pkgs.websocat
    pkgs.w3m
  ];

  lspPkgs = [
    pkgs.gopls
    pkgs.elixir-ls
    pkgs.alejandra
    pkgs.tinymist
    pkgs.lua-language-server
    pkgs.clang-tools
    pkgs.nixd
    pkgs.basedpyright
    pkgs.typescript-language-server
    pkgs.emmet-language-server
    pkgs.tailwindcss-language-server
    pkgs.htmx-lsp
    pkgs.akkuPackages.scheme-langserver
    pkgs.nodePackages.prettier
    pkgs.phpactor
    pkgs.kdePackages.qtdeclarative
    nix-steel.packages.${"x86_64-linux"}.default
    pkgs.neocmakelsp
    # Typst preview
    pkgs.tinymist
    pkgs.websocat
  ];

  guiPkgs = [
    pkgs.vial
    pkgs.qutebrowser
    pkgs.libreoffice
    pkgs.blender
    pkgs.freecad
    pkgs.musescore
    pkgs.vlc
    pkgs.qbittorrent
    zen-browser.packages.${"x86_64-linux"}.default
    quickshell.packages.${"x86_64-linux"}.default
    pkgs.ghostscript
    pkgs.pdfarranger
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
in {
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
