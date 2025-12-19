{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    settings = {
      # Monitor setup
      monitor = "HDMI-A-3,preferred,560,-900,1";

      # General settings
      general = {
        gaps_in = 3;
        gaps_out = 3;
        border_size = 2;
        "col.active_border" = "0xffbabbf1";
        "col.inactive_border" = "0xff414559";
        layout = "master";
      };

      # Decoration settings (rounded corners!)
      decoration = {
        rounding = 10;
        blur = {
          enabled = false;
        };
        shadow = {
          enabled = false;
        };
      };

      # Input settings
      input = {
        kb_layout = "us";
        repeat_rate = 50;
        repeat_delay = 300;
        numlock_by_default = false;
      };

      # Startup applications
      exec-once = [
        "swaybg -i ~/.config/background.png"
        "waybar"
        "mako"
      ];

      # Key bindings
      bind = [
        # Terminal spawning
        "SUPER SHIFT, Return, exec, kitty"
        "SUPER ALT, Return, exec, foot"

        # Application launcher
        "SUPER, D, exec, wofi --show run"

        # Window management
        "SUPER, Q, killactive"
        "SUPER SHIFT, E, exit"

        # Focus navigation (next/previous window in stack)
        "SUPER, J, layoutmsg, cyclenext"
        "SUPER, K, layoutmsg, cycleprev"

        # Swap windows
        "SUPER SHIFT, J, layoutmsg, swapnext"
        "SUPER SHIFT, K, layoutmsg, swapprev"

        # Focus monitor
        "SUPER, Period, focusmonitor, +1"
        "SUPER, Comma, focusmonitor, -1"

        # Move window to monitor
        "SUPER SHIFT, Period, movewindow, mon:+1"
        "SUPER SHIFT, Comma, movewindow, mon:-1"

        # Zoom (bump to top of stack)
        "SUPER, Return, layoutmsg, swapwithmaster master"

        # Master ratio adjustment
        "SUPER, H, layoutmsg, mfact, -0.05"
        "SUPER, L, layoutmsg, mfact, +0.05"

        # Master count adjustment
        "SUPER SHIFT, H, layoutmsg, addmaster, 1"
        "SUPER SHIFT, L, layoutmsg, addmaster, -1"

        # Move windows
        "SUPER ALT, H, movewindow, l"
        "SUPER ALT, J, movewindow, d"
        "SUPER ALT, K, movewindow, u"
        "SUPER ALT, L, movewindow, r"

        # Snap to edges
        "SUPER ALT CTRL, H, movewindow, mon:-1"
        "SUPER ALT CTRL, J, movewindow, mon:+1"
        "SUPER ALT CTRL, K, movewindow, mon:+1"
        "SUPER ALT CTRL, L, movewindow, mon:+1"

        # Resize windows
        "SUPER ALT SHIFT, H, resizeactive, -100 0"
        "SUPER ALT SHIFT, J, resizeactive, 0 100"
        "SUPER ALT SHIFT, K, resizeactive, 0 -100"
        "SUPER ALT SHIFT, L, resizeactive, 100 0"

        # Toggle float
        "SUPER, Space, togglefloating"

        # Toggle fullscreen
        "SUPER, F, fullscreen, 0"

        # Change layout orientation (master location)
        "SUPER, Up, layoutmsg, orientationtop"
        "SUPER, Right, layoutmsg, orientationright"
        "SUPER, Down, layoutmsg, orientationbottom"
        "SUPER, Left, layoutmsg, orientationleft"

        # Passthrough mode (like River)
        "SUPER, F11, submap, passthrough"

        # Tag/Workspace switching (1-9)
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"

        # Move window to workspace
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"

        # Media keys
        ", XF86AudioRaiseVolume, exec, pamixer -i 5"
        ", XF86AudioLowerVolume, exec, pamixer -d 5"
        ", XF86AudioMute, exec, pamixer --toggle-mute"
        ", XF86AudioMedia, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ", XF86Eject, exec, eject -T"
      ];

      # Mouse bindings
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
        "SUPER, mouse:274, togglefloating"
      ];

      # Passthrough mode submaps
      submap = "passthrough" {
        bind = [
          "SUPER, F11, submap, reset"
        ];
      };
      submap = "reset";

      # Window rules
      windowrule = [
        "float, ^(float.*)$"
        "float, title:^(foo)$"
      ];

      # Master layout settings
      master = {
        new_is_master = true;
        new_on_top = false;
        orientation = "left";
        mfact = 0.5;
      };
    };
  };
}
