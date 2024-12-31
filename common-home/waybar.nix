{ config, pkgs, ... }:
{
  stylix.targets.waybar.enable = false;
  programs.waybar = {
    enable = true;
    settings = {
        layer = "top";
        position = "top";

        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
        ];
        modules-right = [
          "custom/packages"
          "cpu"
          "memory"
          "disk"
          "network#wifi"
          "battery"
          "pulseaudio"
          "clock"
          "tray"
          "custom/notification"
        ];
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = " ";
            active = " ";
            urgent = " ";
            #/* "default" = ""; */
            #/* "active" = ""; */
            #/* "urgent" = "" */
          };
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };
        clock = {
          tooltip-format = "{:%Y-%m-%d | %H:%M}";
          format-alt = "{:%Y-%m-%d}";
        };
        "hyprland/window" = {
          max-length = 60;
          separate-outputs = false;
        };
        memory = {
          interval = 5;
          format = " {}%";
        };
        cpu = {
          interval = 5;
          format = " {usage:2}%";
          tooltip = false;
        };
        disk = {
          format = "  {free}/{total}";
          tooltip = false;
        };
        "custom/packages" = {
          exec = "~/.local/bin/packagecount";
          format = " {}";
          interval = 45;
        };
        "network#wifi" = {
          interval = 1;
          interface = "wlp6s0";
          #"interface" = "wlp62s0";
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          format-wifi = "{icon} {signalStrength}%";
          format-disconnected = "󰤮";
          tooltip = false;
        };
        tray = {
          #"icon-size" = 24;
          spacing = 12;
        };
        pulseaudio = {
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
        };
        "custom/notification" = {
          tooltip = false;
          format = "{icon} {}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          escape = true;
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󱘖 {capacity}%";
          format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          on-click = "";
          tooltip = false;
        };
      };
    style = ''
      /* -----------------------------------------------------
      * General 
      * ----------------------------------------------------- */
      * {
        font-size: 16px;
        font-family: Ubuntu Nerd Font, Font Awesome, sans-serif;
        font-weight: bold;
      }

      window#waybar {
        background-color: rgba(26,27,38,0.6);
        border-bottom: 1px solid rgba(26,27,38,0);
        border-radius: 0px;
        color: #f8f8f2;
      }

      /* -----------------------------------------------------
      * Workspaces 
      * ----------------------------------------------------- */
      #workspaces {
        background: #57526c;
        margin: 5px 3px 5px 12px;
        padding: 0px 1px;
        border-radius: 15px;
        border: 0px;
        font-style: normal;
        color: #ada0ae;
      }

      #workspaces button {
        padding: 0px 5px;
        margin: 4px 3px;
        border-radius: 15px;
        border: 0px;
        color: #ada0ae;
        background-color: #ada0ae;
        opacity: 0.5;
        transition: all 0.3s ease-in-out;
      }

      #workspaces button.active {
        color: #ada0ae;
        background: #ada0ae;
        border-radius: 15px;
        min-width: 40px;
        transition: all 0.3s ease-in-out;
        opacity: 1.0;
      }

      #workspaces button:hover {
        color: #ada0ae;
        background: #ada0ae;
        border-radius: 15px;
        opacity: 1.0;
      }


      /* -----------------------------------------------------
      * Tooltips
      * ----------------------------------------------------- */
      tooltip {
      background: #d4bab4;
      border: 2px solid #57526c;
      border-radius: 10px;
      }

      tooltip label {
      color: #57526c;
      }

      /* -----------------------------------------------------
      * Window
      * ----------------------------------------------------- */
      #window {
        color: #ada0ae;
        background: #57526c;
        border-radius: 15px;
        margin: 5px;
        padding: 2px 10px;
      }

      #custom-packages {
        color: #ada0ae;
        background: #57526c;
        border-radius: 15px;
        margin: 5px;
        padding: 2px 10px;
      }

      #memory {
        color: #ada0ae;
        background: #57526c;
        border-radius: 15px;
        margin: 5px;
        padding: 2px 10px;
      }

      #clock {
        color: #ada0ae;
        background: #57526c;
        border-radius: 15px;
        margin: 5px;
        padding: 2px 10px;
      }

      #cpu {
        color: #ada0ae;
        background: #57526c;
        border-radius: 15px;
        margin: 5px;
        padding: 2px 10px;
      }

      #disk {
        color: #ada0ae;
        background: #57526c;
        border-radius: 15px;
        margin: 5px;
        padding: 2px 10px;
      }

      #battery {
        color: #ada0ae;
        background: #57526c;
        border-radius: 15px;
        margin: 5px;
        padding: 2px 10px;
      }

      #network {
        color: #ada0ae;
        background: #57526c;
        border-radius: 15px;
        margin: 5px;
        padding: 2px 10px;
      }

      #tray {
        color: #ada0ae;
        background: #57526c;
        border-radius: 15px;
        margin: 5px;
        padding: 2px 10px;
      }

      #pulseaudio {
        color: #ada0ae;
        background: #57526c;
        border-radius: 15px;
        margin: 5px;
        padding: 2px 10px;
      }

      #custom-notification {
        color: #ada0ae;
        background: #57526c;
        border-radius: 15px;
        margin: 5px;
        padding: 2px 10px;
      }
    '';
  };
}
