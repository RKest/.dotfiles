{ pkgs, lib, config, ... }:
{
  options = {
    hyprland.enable = lib.mkEnableOption "enables hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    home.packages = [
      pkgs.wlogout
      pkgs.waybar
      pkgs.wl-clipboard
      pkgs.hyprshade
      pkgs.wf-recorder
    ];

    home.file."${config.xdg.configHome}/waybar" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/max/.dotfiles/nix-modules/hyprland/waybar";
      recursive = true;
    };

    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";
      "$terminal" = "alacritty";
      "$fileNamager" = "firefox";
      "$menu" = "rofi -show drun -show-icons";

      exec-once = [
	"${lib.getExe pkgs.swaybg} -i ~/Downloads/bg.jpg" 
	"${lib.getExe pkgs.waybar} &"
      ];
      exec = ["${lib.getExe pkgs.hyprshade} on blue-light-filter"];

      env = ["XCURSOR_SIZE,24" "HYPRCURSOR_SIZE,24" "HYPRSHOT_DIR,${config.home.homeDirectory}/Pictures"];

      monitor = [",preferred,auto,2"];

      general = { 
	gaps_in = 2; gaps_out = 5; border_size = 2; 
	"col.active_border" = "rgba(950c13ee) rgba(fb6818ee) 45deg"; "col.inactive_border" = "rgba(595959aa)";
	resize_on_border = false; allow_tearing = false; layout = "dwindle";
      };

      decoration = {
	rounding = 0; active_opacity = 1.0; inactive_opacity = 1.0;
	blur = { enabled = true; size = 10; passes = 2; vibrancy = 0.1696; };
      };

      animations.enabled = false;
      dwindle.pseudotile = true;
      dwindle.preserve_split = true;
      master.new_status  = "master";

      input = {
	kb_layout = "pl"; kb_variant = "basic";
	follow_mouse = 1; sensitivity = 0; touchpad.natural_scroll = false;
	repeat_delay = 300; repeat_rate = 50;
      };
      gestures.workspace_swipe = false;

      bind = [
	"$mod, Q, exec, $terminal"
	"$mod, W, exec, neovide"
	"$mod, C, killactive"
	"$mod, M, exit"
	"$mod, E, exec, $fileManager"
	"$mod, V, togglefloating"
	"$mod, R, exec, $menu"
	"$mod, P, pseudo"
	"$mod, J, togglesplit"

	"$mod, F10, exec, ${lib.getExe pkgs.hyprpicker} | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}"

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

	"$mod, PRINT, exec, ${lib.getExe pkgs.hyprshot} -m region"
      ];

      bindm = [
	"$mod, mouse:272, movewindow"
	"$mod, mouse:273, resizewindow"
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

      windowrulev2 = ["suppressevent maximize, class:.*" "float,class:.*pavucontrol.*"];
    };
  };
}
