{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    settings = {
      monitor = [
        "HDMI-A-2,2560x1080@60,0x0,1"
        "HDMI-A-3,1440x900@60,560x-900,1"
      ];

      dwindle = {
        # force_split = 2;
        preserve_split = true;
      };

      # General settings
      general = {
        gaps_in = 3;
        gaps_out = 6;
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
        kb_options = "caps:escape";
      };

      # Startup applications
      exec-once = [
        "swaybg -i ~/.config/background.png"
        "waybar"
        "mako"
      ];

      animation = [
        "windows, 1, 6, default, slide"
        "workspaces, 1, 6, default, slide"
      ];

      # Key bindings
      bind = [
        # Terminal spawning
        "SUPER, Return, exec, kitty"

        # Application launcher
        "SUPER, D, exec, wofi --show run"
        "SUPER, Q, exec, qutebrowser"
        "SUPER, Y, exec, firefox"

        # Window management
        "SUPER, W, killactive"
        "SUPER SHIFT, Q, exit"

        # Focus navigation (vim keys)
        "SUPER, H, movefocus, l"
        "SUPER, J, movefocus, d"
        "SUPER, K, movefocus, u"
        "SUPER, L, movefocus, r"

        # Swap windows (master layout)
        "SUPER SHIFT, H, swapwindow, l"
        "SUPER SHIFT, J, swapwindow, d"
        "SUPER SHIFT, K, swapwindow, u"
        "SUPER SHIFT, L, swapwindow, r"

        # Focus monitor
        "SUPER, Period, focusmonitor, +1"
        "SUPER, Comma, focusmonitor, -1"

        # Move window to monitor
        "SUPER SHIFT, Period, movewindow, mon:+1"
        "SUPER SHIFT, Comma, movewindow, mon:-1"

        # Master ratio adjustment
        "SUPER CTRL, H, layoutmsg, mfact -0.05"
        "SUPER CTRL, L, layoutmsg, mfact +0.05"

        # Master count adjustment not working right now
        # "SUPER ALT, H, layoutmsg, addmaster -1"
        # "SUPER ALT, L, layoutmsg, addmaster 1"

        # Switch between master and dwindle
        "SUPER ALT, M, exec, hyprctl keyword general:layout master"
        "SUPER ALT, D, exec, hyprctl keyword general:layout dwindle"

        # Focus and switch with master
        "SUPER, M, layoutmsg, focusmaster"
        "SUPER SHIFT, M, layoutmsg, swapwithmaster"

        # Set Master to around 16:9
        "SUPER, A, layoutmsg, mfact exact 0.76"
        "SUPER, S, layoutmsg, mfact exact 0.5"

        # Toggle float
        "SUPER, V, togglefloating"

        # Toggle fullscreen
        "SUPER, F, fullscreen, 0"

        # Toggle maximize (opaque fullscreen)
        "SUPER SHIFT, F, fullscreen, 1"

        # Resize windows (hold and drag alternative)
        "SUPER ALT SHIFT, H, resizeactive, -50 0"
        "SUPER ALT SHIFT, J, resizeactive, 0 50"
        "SUPER ALT SHIFT, K, resizeactive, 0 -50"
        "SUPER ALT SHIFT, L, resizeactive, 50 0"

        "SUPER, left, resizeactive, -50 0"
        "SUPER, right, resizeactive, 50 0"
        "SUPER, up, resizeactive, 0 -50"
        "SUPER, down, resizeactive, 0 50"

        # Pin window (sticky)
        "SUPER SHIFT, P, pin"

        # Passthrough mode
        "SUPER, F11, submap, passthrough"

        # Workspace/Tag switching (1-9)
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

        # Mouse Bindings
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizeactive"
        "SUPER, mouse:274, togglefloating"

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

      # Window rules
      windowrule = [
        "float, class:^(float.*)$"
        "float, title:^(foo)$"
      ];

      # Master layout settings
      master = {
        new_status = "master";
        new_on_top = false;
        orientation = "left";
        mfact = 0.5;
      };
    };
  };
}
