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
        ];

        "custom/sandtimer" = {
          format = "";
          tooltip = false;
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
            default = [" " " "];
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
        padding: 0 2px;
        font-size: 1px;
        color: #fdf6e3;
      }

      #workspaces button.focused {
        color: #268bd2;
      }

      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
      }

      #workspaces button:hover {
        background: #1a1a1a;
        border: #1a1a1a;
        padding: 0 3px;
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
      #disk {
        padding: 0 10px;
      }
    '';
  };
}
