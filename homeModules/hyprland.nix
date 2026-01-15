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
        kb_variant = "de_se_fi"; # Umlauts with AltGr
        repeat_rate = 50;
        repeat_delay = 300;
        numlock_by_default = false;
        kb_options = "caps:escape";
      };

      # Startup applications
      exec-once = [
        "hyprpaper"
        "waybar"
        "mako"
        "openrgb -p default"
        "wl-paste --watch cliphist store"
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
        # Special Workspace
        "$mod SHIFT, S, movetoworkspace, special:scratch"
        "$mod, S, togglespecialworkspace, scratch"

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
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, J, movewindow, d"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, L, movewindow, r"

        "$mod ALT, H, movewindoworgroup, l"
        "$mod ALT, J, movewindoworgroup, d"
        "$mod ALT, K, movewindoworgroup, u"
        "$mod ALT, L, movewindoworgroup, r"

        "$mod CTRL, H, movewindoworgroup, l"
        "$mod CTRL, J, movewindoworgroup, d"
        "$mod CTRL, K, movewindoworgroup, u"
        "$mod CTRL, L, movewindoworgroup, r"

        "$mod, page_up, changegroupactive, b"
        "$mod, page_down, changegroupactive, f"
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
        "$mod, O, layoutmsg, mfact exact 0.76"
        "$mod, I, layoutmsg, mfact exact 0.5"

        # Toggle float
        "$mod, T, togglefloating"

        # Toggle fullscreen
        "$mod, F, fullscreen, 1"

        # Toggle maximize (opaque fullscreen)
        "$mod SHIFT, F, fullscreen, 0"

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

        # Clipboard History
        "$mod, V, exec, cliphist list | wofi -j -S dmenu | cliphist decode | wl-copy"

        "$mod, G, togglegroup"

        "$mod, E, exec, bemoji -n"
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
              "$mod CTRL SHIFT, ${toString ws}, movetoworkspacesilent, ${toString ws}"
            ]
          ) 9
        )
      );

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
      ];

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

      group = {
        auto_group = true;
        groupbar = {
          "col.active" = "rgb(babbf1)";
          "col.inactive" = "rgb(232634)";
          indicator_height = 6;
          render_titles = false;
          stacked = false;
          round_only_edges = false;
          rounding = 3;
        };
      };
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/.config/background.jpeg"
      ];
      wallpaper = [
        "HDMI-A-2,~/.config/background.jpeg"
        "HDMI-A-3,~/.config/background.jpeg"
      ];
      splash = false;
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
      };

      background = {
        path = "$HOME/.config/background";
        blur_passes = 0;
        color = "$base";
      };

      label = [
        {
          monitor = "HDMI-A-2";
          text = ''cmd[update:43200000] date +"%A, %d %B %Y"'';
          color = "$text";
          font_size = 25;
          font_family = "$font";
          position = "-30, -150";
          halign = "right";
          valign = "top";
        }
        {
          monitor = "HDMI-A-2";
          text = "$TIME";
          color = "$text";
          font_size = 90;
          font_family = "$font";
          position = "-30 0";
          halign = "right";
          valign = "top";
        }
      ];

      input-field = [
        {
          monitor = "HDMI-A-2";
          size = "300, 60";
          outline_thickness = 4;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "$accent";
          inner_color = "$surface0";
          font_color = "$text";
          fade_on_empty = false;
          placeholder_text = ''<span foreground="##$textAlpha"><i>󰌾 Logged in as </i><span foreground="##$accentAlpha">$USER</span></span>'';
          hide_input = false;
          check_color = "$accent";
          fail_color = "$red";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          capslock_color = "$yellow";
          position = "0, -47";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "hyprlock";
        }
        {
          timeout = 600;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
