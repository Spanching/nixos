{ config, pkgs, ... }:

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

        modules-left = [
          "custom/sandtimer"
          "river/tags"
          "river/mode"
          "river/window"
        ];
        modules-center = [
          "clock#1"
        ];
        modules-right = [
          "pulseaudio"
          "cpu"
          "memory"
          "tray"
        ];

        "custom/sandtimer" = {
          format = "";
          tooltip = false;
        };
        "sway/workspaces" = {
          disable-scroll = true;
          format = "{name}";
        };

        "clock#1" = {
          format = "{:%a %d-%m-%y %H:%M}";
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
          format = "Mem {}%";
        };
        "cpu" = {
          interval = 5;
          format = "CPU {usage:2}%";
        };
        "disk" = {
          interval = 5;
          format = "Disk {percentage_used:2}%";
          path = "/";
        };
        "tray" = {
          icon-size = 20;
        };
      };
    };
    style = ''
      @define-color rosewater #f2d5cf;
      @define-color flamingo #eebebe;
      @define-color pink #f4b8e4;
      @define-color mauve #ca9ee6;
      @define-color red #e78284;
      @define-color maroon #ea999c;
      @define-color peach #ef9f76;
      @define-color yellow #e5c890;
      @define-color green #a6d189;
      @define-color teal #81c8be;
      @define-color sky #99d1db;
      @define-color sapphire #85c1dc;
      @define-color blue #8caaee;
      @define-color lavender #babbf1;
      @define-color text #c6d0f5;
      @define-color subtext1 #b5bfe2;
      @define-color subtext0 #a5adce;
      @define-color overlay2 #949cbb;
      @define-color overlay1 #838ba7;
      @define-color overlay0 #737994;
      @define-color surface2 #626880;
      @define-color surface1 #51576d;
      @define-color surface0 #414559;
      @define-color base #303446;
      @define-color mantle #292c3c;
      @define-color crust #232634;

      * {
        font-size: 14px;
      }

      window#waybar {
        border-radius: 10px;
        background: rgba(35, 38, 54, 0.99);
        margin: 4px;
        color: @blue;
      }

      #custom-sandtimer {
        color: @rosewater;
        padding: 0 10px;
      }

      #workspaces,
      #clock.1,
      #clock.2,
      #clock.3,
      #pulseaudio,
      #memory,
      #cpu,
      #battery,
      #disk,
      #tray {
      }

      #workspaces button {
        padding: 0 2px;
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
      #disk {
        color: @text;
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
