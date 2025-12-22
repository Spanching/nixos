{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    settings = {
      "$mod" = "SUPER";
      monitor = [
        "HDMI-A-2,2560x1080@60,0x0,1"
        "HDMI-A-3,1440x900@60,560x-900,1"
      ];

      dwindle = {
        # force_split = 2;
        preserve_split = true;
      };

      general = {
        gaps_in = 3;
        gaps_out = 6;
        border_size = 2;
        "col.active_border" = "0xffbabbf1";
        "col.inactive_border" = "0xff414559";
        layout = "master";
      };

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

      workspace = [
        "1,monitor:HDMI-A-2"
        "2,monitor:HDMI-A-2"
        "3,monitor:HDMI-A-2"
        "4,monitor:HDMI-A-2"
        "5,monitor:HDMI-A-3"
        "6,monitor:HDMI-A-3"
        "7,monitor:HDMI-A-3"
        "8,monitor:HDMI-A-3"
        "9,monitor:HDMI-A-3"
      ];

      binds = {
        drag_threshold = 10;
      };

      # Key bindings
      bind = [
        # Terminal spawning
        "$mod, Return, exec, kitty"

        # Application launcher
        "$mod, D, exec, wofi --show run"
        "$mod, Q, exec, qutebrowser"
        "$mod, Y, exec, firefox"

        # Window management
        "$mod, W, killactive"
        "$mod SHIFT, Q, exit"

        # Focus navigation (vim keys)
        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"

        # Swap windows (master layout)
        "$mod SHIFT, H, swapwindow, l"
        "$mod SHIFT, J, swapwindow, d"
        "$mod SHIFT, K, swapwindow, u"
        "$mod SHIFT, L, swapwindow, r"

        # Focus monitor
        "$mod, Period, focusmonitor, +1"
        "$mod, Comma, focusmonitor, -1"

        # Move window to monitor
        "$mod SHIFT, Period, movewindow, mon:+1"
        "$mod SHIFT, Comma, movewindow, mon:-1"

        # Master ratio adjustment
        "$mod CTRL, H, layoutmsg, mfact -0.05"
        "$mod CTRL, L, layoutmsg, mfact +0.05"

        # Master count adjustment not working right now
        # "$mod ALT, H, layoutmsg, addmaster -1"
        # "$mod ALT, L, layoutmsg, addmaster 1"

        # Switch between master and dwindle
        "$mod ALT, M, exec, hyprctl keyword general:layout master"
        "$mod ALT, D, exec, hyprctl keyword general:layout dwindle"

        # Focus and switch with master
        "$mod, M, layoutmsg, focusmaster"
        "$mod SHIFT, M, layoutmsg, swapwithmaster"

        # Set Master to around 16:9
        "$mod, A, layoutmsg, mfact exact 0.76"
        "$mod, S, layoutmsg, mfact exact 0.5"

        # Toggle float
        "$mod, V, togglefloating"

        # Toggle fullscreen
        "$mod, F, fullscreen, 0"

        # Toggle maximize (opaque fullscreen)
        "$mod SHIFT, F, fullscreen, 1"

        # Resize windows (hold and drag alternative)
        "$mod ALT SHIFT, H, resizeactive, -50 0"
        "$mod ALT SHIFT, J, resizeactive, 0 50"
        "$mod ALT SHIFT, K, resizeactive, 0 -50"
        "$mod ALT SHIFT, L, resizeactive, 50 0"

        "$mod, left, resizeactive, -50 0"
        "$mod, right, resizeactive, 50 0"
        "$mod, up, resizeactive, 0 -50"
        "$mod, down, resizeactive, 0 50"

        # Pin window (sticky)
        "$mod SHIFT, P, pin"

        # Mouse Bindings
        "$mod, mouse_down, workspace, e-1"
        "$mod, mouse_up, workspace, e+1"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = i + 1;
            in
            [
              "$mod, ${toString ws}, workspace, ${toString ws}"
              "$mod SHIFT, ${toString ws}, movetoworkspace, ${toString ws}"
              "$mod CTRL ALT, ${toString ws}, movetoworkspacesilent, ${toString ws}"
            ]
          ) 9
        )
      );

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizeactive"
      ];

      bindc = [
        "$mod, mouse:274, togglefloating"
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
