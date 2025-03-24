{
  isLaptop,
  pkgs,
  lib,
  config,
  ...
}: let
  zoomIn = amount: ''
    curr=`hyprctl getoption cursor:zoom_factor | head -n 1 | awk '{print $2}'` && hyprctl keyword cursor:zoom_factor `echo "$curr + ${lib.strings.floatToString amount}" | bc`
  '';
  mod = "SUPER";
in {
  options = {
    hyprland.enable = lib.mkEnableOption "enables hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    home.packages = [
      pkgs.bc
      pkgs.wlogout
      pkgs.wl-clipboard
      pkgs.hyprshade
      pkgs.wf-recorder
    ];

    programs.hyprpanel = {
      enable = true;
      hyprland.enable = true;

      theme = "monochrome";
      override = {
        theme.bar.background = "#000000";
      };

      layout = {
        "bar.layouts" = {
          "*" = {
            left = ["workspaces" "windowtitle"];
            middle = ["media"];
            right = ["network" "bluetooth" "volume" (lib.mkIf isLaptop "battery") "clock" "dashboard"];
          };
        };
        "bar.workspaces.applicationIconMap" = {
          "brave-browser" = "󰖟";
          "Alacritty" = "󰞷";
          "firefox" = "󰈹";
          "org.gnome.Nautilus" = "";
          "Neovide" = "";
          "Obsidian" = "";
          "Emacs" = "";
          "org.pwmt.zathura" = "󰐣";
          "com.mitchellh.ghostty" = "󰊠";
          "org.qutebrowser.qutebrowser" = "";
          "zen" = "󰖟";
        };
      };

      settings = {
        scalingPriority = "hyprland";
        menus.clock.time.hideSeconds = true;
        menus.clock.time.military = true;
        bar = {
          workspaces.showApplicationIcons = true;
          workspaces.showWsIcons = true;
          workspaces.show_icons = false;
          launcher.autoDetectIcon = true;
          clock.format = "%H:%M";
          clock.icon = "";
          network.label = false;
          bluetooth.label = false;
        };
        theme = {
          bar.outer_spacing = "0em";
          font = {
            name = "JetBrains NFM";
            size = "1rem";
          };
        };
      };
    };

    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "${lib.getExe pkgs.swaybg} -i ~/Downloads/bg.jpg"
      ];
      exec = ["${lib.getExe pkgs.hyprshade} on blue-light-filter"];

      env = [
        "EDITOR,nvim"
        "GTK_THEME,Adwaita:dark"
        "FLAKE,/etc/nixos/flake.nix" # Nixos flake path for nh

        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "HYPRSHOT_DIR,${config.home.homeDirectory}/Pictures"
      ];

      monitor = [",preferred,auto,2"];

      general = {
        gaps_in = 2;
        gaps_out = 1;
        border_size = 1;
        "col.active_border" = "rgba(950c13ee) rgba(fb6818ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        blur = {
          enabled = true;
          size = 10;
          passes = 2;
          vibrancy = 0.1696;
        };
      };

      animations.enabled = false;
      dwindle.pseudotile = true;
      dwindle.preserve_split = true;
      master.new_status = "master";

      input = {
        kb_layout = "pl";
        kb_variant = "basic";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad.natural_scroll = false;
        repeat_delay = 300;
        repeat_rate = 50;
      };
      gestures.workspace_swipe = false;

      workspace = [
        "w[t1], gapsout:0, gapsin:0"
        "w[tg1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "float,class:.*pavucontrol.*"
        "bordersize 0, floating:0, onworkspace:w[t1]"
        "rounding 0, floating:0, onworkspace:w[t1]"
        "bordersize 0, floating:0, onworkspace:w[tg1]"
        "rounding 0, floating:0, onworkspace:w[tg1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
      ];

      binds.scroll_event_delay = 0;
      bind = [
        "${mod}, W, exec, ${lib.getExe pkgs.alacritty}"
        "${mod}, Q, killactive"
        "${mod}, M, exit"
        "${mod}, V, togglefloating"
        "${mod}, R, exec, rofi -show drun -show-icons"
        "${mod}, P, pseudo"
        "${mod}, J, togglesplit"

        "${mod}, F10, exec, ${lib.getExe pkgs.hyprpicker} | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}"

        "${mod}, left, movefocus, l"
        "${mod}, right, movefocus, r"
        "${mod}, up, movefocus, u"
        "${mod}, down, movefocus, d"

        "${mod}, 1, workspace, 1"
        "${mod}, 2, workspace, 2"
        "${mod}, 3, workspace, 3"
        "${mod}, 4, workspace, 4"
        "${mod}, 5, workspace, 5"
        "${mod}, 6, workspace, 6"
        "${mod}, 7, workspace, 7"
        "${mod}, 8, workspace, 8"
        "${mod}, 9, workspace, 9"
        "${mod}, 0, workspace, 10"

        "${mod} SHIFT, 1, movetoworkspace, 1"
        "${mod} SHIFT, 2, movetoworkspace, 2"
        "${mod} SHIFT, 3, movetoworkspace, 3"
        "${mod} SHIFT, 4, movetoworkspace, 4"
        "${mod} SHIFT, 5, movetoworkspace, 5"
        "${mod} SHIFT, 6, movetoworkspace, 6"
        "${mod} SHIFT, 7, movetoworkspace, 7"
        "${mod} SHIFT, 8, movetoworkspace, 8"
        "${mod} SHIFT, 9, movetoworkspace, 9"
        "${mod} SHIFT, 0, movetoworkspace, 10"

        "${mod}, S, togglespecialworkspace, magic"
        "${mod} SHIFT, S, movetoworkspace, special:magic"

        "${mod}, mouse_down, workspace, e+1"
        "${mod}, mouse_up, workspace, e-1"

        "${mod}, J, workspace, e-1"
        "${mod}, K, workspace, e+1"

        "${mod}, PRINT, exec, ${lib.getExe pkgs.hyprshot} -m region"

        "${mod} SHIFT, mouse_up, exec, hyprctl keyword cursor:zoom_factor 1.0"
        "${mod} SHIFT, mouse_down, exec, ${zoomIn 0.5}"
      ];

      bindm = [
        "${mod}, mouse:272, movewindow"
        "${mod}, mouse:273, resizewindow"
      ];

      bindle = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      bindl = [
        ",XF86AudioPlay, exec, playerctl play-pause"
      ];
    };
  };
}
