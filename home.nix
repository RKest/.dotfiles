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
      if [ -n "''${commands[fzf-share]}" ]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
      fi

      source "/home/max/.dotfiles/zsh/.p10k.zsh"

      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      bindkey  "^[[H"   beginning-of-line
      bindkey  "^[[F"   end-of-line
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

    animations.enabled = false;
    dwindle.pseudotile = true;
    dwindle.preserve_split = true;
    master.new_status  = "master";

    input = {
      kb_layout = "pl"; kb_variant = "basic";
      follow_mouse = 1; sensitivity = 0; touchpad.natural_scroll = false;
    };
    gestures.workspace_swipe = false;

    bind = [
      "$mod, Q, exec, $terminal"
      "$mod, C, killactive"
      "$mod, M, exit"
      "$mod, E, exec, $fileManager"
      "$mod, V, togglefloating"
      "$mod, R, exec, $menu"
      "$mod, P, pseudo"
      "$mod, J, togglesplit"

      "$mod, F10, exec, hyprpicker | wl-copy"

      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"

      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 0, workspace, 10"

      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod SHIFT, 0, movetoworkspace, 10"

      "$mod, S, togglespecialworkspace, magic"
      "$mod SHIFT, S, movetoworkspace, special:magic"

      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"
    ];

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
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
}
