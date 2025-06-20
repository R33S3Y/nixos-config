{ config, pkgs, ... }:
{
  stylix.targets.waybar.enable = false;
  programs.waybar = {
    enable = true;
    settings = [{
      #layer = "top";
      position = "top";

      modules-left = [
        "hyprland/workspaces"
      ];
      #modules-center = [
      #];
      modules-right = [
        "cpu"
        "memory"
        "disk"
        "network#wifi"
        "battery"
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
        format = "RAM: {}%";
      };
      cpu = {
        interval = 5;
        format = "CPU: {usage:2}%";
        tooltip = false;
      };
      disk = {
        format = "Disk: {free}/{total}";
        tooltip = false;
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
    }];
  };
}
