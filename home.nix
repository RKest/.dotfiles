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
  nixpkgs.config.allowUnfree = true;
  home.username = "max";
  home.homeDirectory = "/home/max";

  home.stateVersion = "24.05"; # Don't change

  home.packages = [
    # Universal ternmial packages
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
    pkgs.htop
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    # Gui packages
    pkgs.alacritty
    pkgs.nautilus
    pkgs.firefox
    pkgs.obsidian

    # Hyprland packages
    pkgs.hyprshade
    pkgs.wl-clipboard
    pkgs.swaybg
    pkgs.hyprpicker
    pkgs.waybar
    pkgs.rofi-wayland

    # Media packages
    pkgs.ytarchive
  ];
  
  home.file = {
    ".gitconfig".source = config.lib.file.mkOutOfStoreSymlink "/home/max/.dotfiles/.gitconfig";
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
    GTK_THEME = "Adwaita:dark";
    # GTK_THEME = "Tokyonight-Dark-B";
  };

  programs.home-manager.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      c = "clear";
      llc = "ls -la --color";
    };
    initExtra = ''
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word

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
      set-option -g default-shell ${pkgs.zsh}/bin/zsh
      set-option -g renumber-windows on

      bind -n S-Left  previous-window
      bind -n S-Right next-window
      bind -n M-H previous-window
      bind -n M-L next-window
    '';
  };

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    systemd.enable = true;

    "$mod" = "SUPER";
    "$terminal" = "alacritty";
    "$fileNamager" = "firefox";
    "$menu" = "rofi -show drun";

    exec-once = ["swaybg -i ~/Downloads/bg.jpg" "waybar &"];
    exec = ["hyprshade on blue-light-filter"];

    env = ["XCURSOR_SIZE,24" "HYPRCURSOR_SIZE,24"];

    monitor = [",preferred,auto,1"];

    general = { 
      gaps_in = 2; gaps_out = 5; border_size = 2; 
      "col.active_border" = "rgba(950c13ee) rgba(fb6818ee) 45deg"; "col.inactive_border" = "rgba(595959aa)";
      resize_on_border = false; allow_tearing = false; layout = "dwindle";
    };

    decoration = {
      rounding = 0; active_opacity = 1.0; inactive_opacity = 1.0; drop_shadow = true;
      shadow_range = 4; shadow_render_power = 3; "col.shadow" = "rgba(1a1a1aee)";
      blur = { enabled = true; size = 10; passes = 2; vibrancy = 0.1696; };
    };

    anumations.enabled = false;
    diwndle.pseudotile = true;
    diwndle.preserve_split = true;
    master.new_status  = "master";

    input = {
      kb_layout = "pl"; kb_variant = "basic";
      follow_mouse = 1; sensitivity = 0; touchpad.natural_scroll = false;
    };
    gestures.workspace_swipe = false;

    bind = [
      "$mainMod, Q, exec, $terminal"
      "$mainMod, C, killactive"
      "$mainMod, M, exit"
      "$mainMod, E, exec, $fileManager"
      "$mainMod, V, togglefloating"
      "$mainMod, R, exec, $menu"
      "$mainMod, P, pseudo"
      "$mainMod, J, togglesplit"

      "$mainMod, F10, exec, hyprpicker | wl-copy"

      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"

      "$mainMod, S, togglespecialworkspace, magic"
      "$mainMod SHIFT, S, movetoworkspace, special:magic"

      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"
    ];

    bindm = [
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"
    ];

    bindel = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
      ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
    ];

    windowrulev2 = ["suppressevent maximize, class:.*" "float,class:.*pavucontrol.*"];
  };

  dconf = {
    settings = {
      "org/gnome/desktop/interface" = {
	gtk-theme = "Adwaita-dark";
	color-scheme = "prefer-dark";
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "Adwaita-dark";
    style = {
      name = "Adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      configPackages = with pkgs; [ xdg-desktop-portal-gtk ];
  };
}
