{ pkgs, hyprland-plugins, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";
    # package is now provided by hyprland.homeManagerModules.default
    plugins = [ ];
    settings = {
      "$mod" = "SUPER";

      modeline = [
        "HDMI-A-2,2560x1080_60.00, 230.00, 2560, 2720, 2992, 3424, 1080, 1083, 1093, 1120, -hsync, +vsync"
      ];

      monitor = [
        "HDMI-A-2,2560x1080@60,0x0,1" # Ultrawide
        "HDMI-A-3,1440x900@60,560x-900,1" # Small top
        "HDMI-A-1,disable" # TV
        ", preferred, auto, 1"
      ];

      debug = {
        disable_logs = false;
      };

      dwindle = {
        # force_split = 2;
        preserve_split = true;
      };

      cursor = {
        no_warps = true;
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
        dim_special = 0.0;
      };

      blurls = [ ];

      device = {
        name = "weylus-stylus";
        output = "HDMI-A-2";
      };
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        vrr = 1;
      };

      # Input settings
      input = {
        kb_layout = "us";
        kb_variant = "de_se_fi"; # Umlauts with AltGr
        repeat_rate = 50;
        repeat_delay = 300;
        numlock_by_default = false;
        kb_options = "caps:escape";
        follow_mouse = 1;
      };

      # Startup applications
      exec-once = [
        "hyprpaper"
        "waybar &> ~/waybar_startup.log"
        "mako"
        "openrgb -p default"
        "wl-paste --watch cliphist store"
      ];

      animation = [
        "global, 1, 3, default"
        "fade, 0"
        "layers, 0"
        "workspaces, 1, 6, default"
        "specialWorkspace, 1, 3, default, slidevert"
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
        "$mod CTRL, Return, exec, fish"
        "ALT, SPACE, exec, kitty --class=\"floating-search\" -e sh -c \"fd --type f --hidden --exclude .git | fzf --layout=reverse | xargs -r xdg-open\""

        # Application launcher
        "$mod, D, exec, wofi --show run"
        "$mod, Y, exec, firefox"

        # Window management
        "$mod, W, killactive"
        "$mod SHIFT, W, forcekillactive"
        "$mod SHIFT, Q, exit"
        "$mod, Escape, exec, hyprlock"
        "$mod SHIFT, E, exec, bemoji -n"
        "$mod, E, exec, dolphin"

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

        "$mod, page_down, changegroupactive, b"
        "$mod, page_up, changegroupactive, f"
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

        "$mod, TAB, layoutmsg, rollnext"

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
        "$mod, mouse_down, workspace, -1"
        "$mod, mouse_up, workspace, +1"

        # Clipboard History
        "$mod, V, exec, cliphist list | wofi -j -S dmenu | cliphist decode | wl-copy"

        "$mod, G, togglegroup"

        # Workspace overview (Hyprexpo plugin)
        # "$mod, Tab, hyprexpo:expo, toggle"

        "$mod CTRL, left, workspace, -1"
        "$mod CTRL, right, workspace, +1"

        "$mod, Print, exec, grim -g \"$(slurp)\" - | swappy -f -"
        "$mod SHIFT, Print, exec, grim"
        ''$mod ALT, Print, exec, grim -o "$(hyprctl -j monitors | jq -r '.[] | select(.focused) | .name')"''
        ''$mod CTRL, Print, exec, grim -g "$(hyprctl -j activewindow | jq -j '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')"''
        # "$mod, Print, exec grim --notify save screen $($HOME/pictures)/$(TZ=utc date +'screenshot_%Y-%m-%d-%H%M%S.%3N.png')" # All visible outputs
        # "$mod, Shift+Print, exec grim --notify save area $($HOME/pictures)/$(TZ=utc date +'screenshot_%Y-%m-%d-%H%M%S.%3N.png')" # Manually select a region
        # "$mod, Alt+Print, exec grim --notify save active $($HOME/pictures)/$(TZ=utc date +'screenshot_%Y-%m-%d-%H%M%S.%3N.png')" # Currently active window
        # "$mod, Shift+Alt+Print, exec grim --notify save window $($HOME/pictures)/$(TZ=utc date +'screenshot_%Y-%m-%d-%H%M%S.%3N.png')" # Manually select a window
        # "$mod, Ctrl+Print, exec grim --notify copy screen"
        # "$mod, Ctrl+Shift+Print, exec grim --notify copy area"
        # "$mod, Ctrl+Alt+Print, exec grim --notify copy active"
        # "$mod, Ctrl+Shift+Alt+Print, exec grim --notify copy window"
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

      # Mouse config in solaar to be used here:
      # buttons:
      # - !Button {behavior: 8, type: 1, value: 1}     # Left click
      # - !Button {behavior: 8, type: 1, value: 2}     # Right click
      # - !Button {behavior: 8, type: 1, value: 4}     # Middle click
      # - !Button {behavior: 8, type: 1, value: 8}     # Back
      # - !Button {behavior: 8, type: 1, value: 16}    # Forward (was DPI shift)
      # - !Button {behavior: 8, type: 1, value: 32}    # Button 6 (DPI button)
      # - !Button {behavior: 8, type: 1, value: 64}    # Button 7
      # - !Button {behavior: 8, type: 1, value: 128}   # Button 8
      # - !Button {behavior: 8, type: 1, value: 256}   # Button 9
      # - !Button {behavior: 8, type: 1, value: 512}   # Button 10
      # - !Button {behavior: 8, type: 1, value: 1024}  # Button 11
      bindc = [
        "$mod, mouse:274, togglefloating"

        ", mouse:276, exec, playerctl play-pause" # side thumb

        ''
          , mouse:281, exec, ~/.local/bin/focus_action.sh \
                    "firefox" \
                    "hyprctl dispatch sendshortcut CTRL SHIFT, t, activewindow" \
                    "hyprctl dispatch cyclenext prev"
        '' # top front

        ''
          , mouse:282, exec, ~/.local/bin/focus_action.sh \
                    "firefox" \
                    "hyprctl dispatch sendshortcut CTRL, w, activewindow" \
                    "hyprctl dispatch cyclenext"
        '' # top back

        ''
          , mouse:277, exec, ~/.local/bin/focus_action.sh \
                    "firefox" \
                    "hyprctl dispatch sendshortcut CTRL, TAB, activewindow" \
                    "hyprctl dispatch workspace +1"
        '' # side front

        ''
          , mouse:275, exec, ~/.local/bin/focus_action.sh \
                    "firefox" \
                    "hyprctl dispatch sendshortcut CTRL SHIFT, TAB, activewindow" \
                    "hyprctl dispatch workspace -1"
        '' # side back

        "$mod, mouse:275, togglefloating" # side back
        "$mod, mouse:276, togglefloating" # side thumb
        "$mod, mouse:277, togglefloating" # side front

        # MMB Left 278, MMB right 279, MMB 274
        # left 272, right 273
        # side thumb 276, side front 277, side back 275
        # top front 281, top back 282
      ];

      windowrule = [
        "match:class ^(floating-search)$, float on, size 800 600, center on"

        "match:class ^(openscad)$, match:title ((3D Print|Welcome).*), float on, size 800 600, center on"
        "match:class ^(org.pulseaudio.pavucontrol)$, float on, size 800 600, center on"
        "focus_on_activate 1, match:class (jetbrains-.*), match:title (win.*), match:initial_title (win.*), match:float 1"
        "stay_focused 1, float 1, focus_on_activate 1, match:class ^(jetbrains-.*)$, match:title (^$)"
        "focus_on_activate 1, match:class ^(jetbrains-.*)$, match:title (.+)"
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
        "col.border_active" = "rgb(186,187,241)";
        "col.border_inactive" = "rgb(48,52,70)";
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

      # Hyprexpo plugin settings
      plugin = {
        hyprexpo = {
          columns = 2;
          gap_size = 6;
          bg_col = "rgb(232634)";
          workspace_method = "first 1";
          enable_gesture = false;
        };
      };
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = [
        {
          monitor = "";
          path = "~/.config/background.jpeg";
        }
      ];
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
        before_sleep_cmd = "pidof hyprlock || hyprlock";
        after_sleep_cmd = "sleep 2 && hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "pidof hyprlock || hyprlock";
        }
        {
          timeout = 600;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 900;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  home.file.".local/bin/focus_action.sh" = {
    text = ''
      #!/usr/bin/env bash
      # Usage: ./focus_action.sh <target_class> <cmd_if_match> <cmd_if_no_match>

      # Script configuration
      readonly SCRIPT_NAME="$(basename "$0")"
      readonly LOG_PREFIX="[$SCRIPT_NAME]"

      TARGET_CLASS="$1"
      MATCH_CMD="$2"
      OTHER_CMD="$3"

      log() {
          local level="$1"
          shift
          echo "$LOG_PREFIX [$level] $*" >&2
      }

      log "INFO" "Script started"
      log "DEBUG" "Target class: '$TARGET_CLASS'"
      log "DEBUG" "Match command: '$MATCH_CMD'"
      log "DEBUG" "No-match command: '$OTHER_CMD'"

      # Get current window class using JSON output
      log "DEBUG" "Querying active window information..."
      if ! ACTIVE_WINDOW_JSON=$(hyprctl activewindow -j 2>&1); then
          log "ERROR" "Failed to get active window information: $ACTIVE_WINDOW_JSON"
          exit 2
      fi

      log "DEBUG" "Parsing window class from JSON..."
      if ! CURRENT_CLASS=$(echo "$ACTIVE_WINDOW_JSON" | ${pkgs.jq}/bin/jq -r '.class' 2>&1); then
          log "ERROR" "Failed to parse window class: $CURRENT_CLASS"
          exit 3
      fi

      log "INFO" "Current window class: '$CURRENT_CLASS'"

      # Compare and execute appropriate command
      if [[ "$CURRENT_CLASS" == "$TARGET_CLASS" ]]; then
          log "INFO" "Class MATCHED - executing match command"
          log "DEBUG" "Executing: $MATCH_CMD"
          
          if eval "$MATCH_CMD"; then
              log "INFO" "Match command executed successfully"
          else
              EXIT_CODE=$?
              log "ERROR" "Match command failed with exit code: $EXIT_CODE"
              exit $EXIT_CODE
          fi
      else
          log "INFO" "Class NOT matched - executing no-match command"
          log "DEBUG" "Expected: '$TARGET_CLASS', Got: '$CURRENT_CLASS'"
          log "DEBUG" "Executing: $OTHER_CMD"
          
          if eval "$OTHER_CMD"; then
              log "INFO" "No-match command executed successfully"
          else
              EXIT_CODE=$?
              log "ERROR" "No-match command failed with exit code: $EXIT_CODE"
              exit $EXIT_CODE
          fi
      fi

      log "INFO" "Script completed successfully"
    '';
    executable = true;
  };
}
