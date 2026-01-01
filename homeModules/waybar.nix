{ ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin-top = 6;
        margin-left = 6;
        margin-right = 6;
        margin-bottom = 0;

        height = 30;

        modules-left = [
          "custom/sandtimer"
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [
          "clock#1"
        ];
        modules-right = [
          "bluetooth"
          "pulseaudio"
          "cpu"
          "memory"
          # "network"
        ];

        "custom/sandtimer" = {
          format = "";
          tooltip = false;
        };

        "hyprland/workspaces" = {
          format = "{icon}  {windows}";
          window-rewrite-default = " ";
          window-rewrite = {
            "class<.*firefox.*>" = " ";
            "class<.*kitty.*>" = " ";
            "class<.*discord.*>" = " ";
            "class<.*spotify.*>" = " ";
            "class<.*steam.*>" = " ";
            "class<.*qutebrowser.*>" = " ";
            "title<.*youtube.*>" = " ";
          };
        };

        "hyprland/window" = {
          # format = "";
          format = "{class} {title}"; # Use for debugging and window-rewrite
        };

        "clock#1" = {
          format = "{:%d.%m.%Y %H:%M}";
          tooltip = false;
        };

        "pulseaudio" = {
          format = "{icon} {volume:2}%";
          format-bluetooth = "{icon}  {volume}%";
          format-muted = "MUTE";
          format-icons = {
            headphones = "";
            default = [
              " "
              " "
            ];
          };
          scroll-step = 5;
          on-click = "pamixer -t";
          on-click-right = "pavucontrol";
          tooltip = false;
        };

        "memory" = {
          interval = 5;
          format = "  {percentage:2}%";
        };

        "cpu" = {
          interval = 5;
          format = "  {usage:2}%";
        };

        "disk" = {
          interval = 5;
          format = "Disk {percentage_used:2}%";
          path = "/";
        };

        "network" = {
          "format-ethernet" = "{bandwidthUpBytes}  {bandwidthDownBytes}";
          "tooltip-format-ethernet" = "{ifname} ";
          "tooltip-format-disconnected" = "Disconnected";
        };
      };
    };
    style = ''
      * {
        font-size: 12px;
        min-height: 0;
      }

      window#waybar {
        border-radius: 10px;
        background: rgba(35, 38, 54, 0.99);
        margin: 4px;
        color: @text;
      }

      #custom-sandtimer {
        color: @blue;
        font-size: 16px;
        padding: 0 15px;
      }

      #clock.1 {
        color: @text;
      }

      #workspaces button {
        margin: 3px;
        padding: 3px;
        color: @subtext0;
      }

      #workspaces button.active {
        color: #fdf6e3;
      }

      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        background: @surface0;
        border: @surface0;
      }

      #pulseaudio {
        color: @blue;
      }

      #memory {
        color: @yellow;
      }

      #cpu {
        color: @green;
      }

      #clock {
        color: @rosewater;
      }

      #pulseaudio,
      #memory,
      #cpu,
      #battery,
      #network,
      #disk {
        padding: 0 10px;
      }
    '';
  };
}
