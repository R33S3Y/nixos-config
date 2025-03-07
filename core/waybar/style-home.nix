{ config, pkgs, ... }:
{
  stylix.targets.waybar.enable = false;
  programs.waybar = {
    enable = true;
    style = ''
      /* -----------------------------------------------------
      * General 
      * ----------------------------------------------------- */
      * {
        font-size: 16px;
        font-family: DejaVu Sans;
        font-weight: bold;
      }

      window#waybar {
        background-color: rgba(26,27,38,0.6);
        border-bottom: 1px solid rgba(26,27,38,0);
        border-radius: 0px;
        color: #${config.stylix.base16Scheme.base0B};
      }

      /* -----------------------------------------------------
      * Workspaces 
      * ----------------------------------------------------- */
      #workspaces {
        background: #${config.stylix.base16Scheme.base0B};
        margin: 5px 3px 5px 12px;
        padding: 0px 1px;
        border-radius: 15px;
        border: 0px;
        font-style: normal;
        color: #${config.stylix.base16Scheme.base06};
      }

      #workspaces button {
        padding: 0px 5px;
        margin: 4px 3px;
        border-radius: 15px;
        border: 0px;
        color: #${config.stylix.base16Scheme.base06};
        background-color: #${config.stylix.base16Scheme.base06};
        opacity: 0.5;
        transition: all 0.3s ease-in-out;
      }

      #workspaces button.active {
        color: #${config.stylix.base16Scheme.base06};
        background: #${config.stylix.base16Scheme.base06};
        border-radius: 15px;
        min-width: 40px;
        transition: all 0.3s ease-in-out;
        opacity: 1.0;
      }

      #workspaces button:hover {
        color: #${config.stylix.base16Scheme.base06};
        background: #${config.stylix.base16Scheme.base06};
        padding: 0px 5px;
        margin: 4px 3px;
        border-radius: 15px;
        border: 0px;
        opacity: 1.0;
      }


      /* -----------------------------------------------------
      * Tooltips
      * ----------------------------------------------------- */
      tooltip {
      background: #d4bab4;
      border: 2px solid #${config.stylix.base16Scheme.base0B};
      border-radius: 10px;
      }

      tooltip label {
      color: #${config.stylix.base16Scheme.base0B};
      }

      /* -----------------------------------------------------
      * Window
      * ----------------------------------------------------- */
      #window {
        color: #${config.stylix.base16Scheme.base06};
        background: #${config.stylix.base16Scheme.base0B};
        border-radius: 15px;
        margin: 5px;
        padding: 2px 10px;
      }

      #custom-packages {
        color: #${config.stylix.base16Scheme.base06};
        background: #${config.stylix.base16Scheme.base0B};
        border-radius: 15px;
        margin: 5px;
        padding: 2px 10px;
      }

      #memory {
        color: #${config.stylix.base16Scheme.base06};
        background: #${config.stylix.base16Scheme.base0B};
        border-radius: 15px;
        margin: 5px;
        padding: 2px 10px;
      }

      #clock {
        color: #${config.stylix.base16Scheme.base06};
        background: #${config.stylix.base16Scheme.base0B};
        border-radius: 15px;
        margin: 5px;
        padding: 2px 10px;
      }

      #cpu {
        color: #${config.stylix.base16Scheme.base06};
        background: #${config.stylix.base16Scheme.base0B};
        border-radius: 15px;
        margin: 5px;
        padding: 2px 10px;
      }

      #disk {
        color: #${config.stylix.base16Scheme.base06};
        background: #${config.stylix.base16Scheme.base0B};
        border-radius: 15px;
        margin: 5px;
        padding: 2px 10px;
      }

      #battery {
        color: #${config.stylix.base16Scheme.base06};
        background: #${config.stylix.base16Scheme.base0B};
        border-radius: 15px;
        margin: 5px;
        padding: 2px 10px;
      }

      #network {
        color: #${config.stylix.base16Scheme.base06};
        background: #${config.stylix.base16Scheme.base0B};
        border-radius: 15px;
        margin: 5px;
        padding: 2px 10px;
      }

      #tray {
        color: #${config.stylix.base16Scheme.base06};
        background: #${config.stylix.base16Scheme.base0B};
        border-radius: 15px;
        margin: 5px;
        padding: 2px 10px;
      }

      #pulseaudio {
        color: #${config.stylix.base16Scheme.base06};
        background: #${config.stylix.base16Scheme.base0B};
        border-radius: 15px;
        margin: 5px;
        padding: 2px 10px;
      }

      #custom-notification {
        color: #${config.stylix.base16Scheme.base06};
        background: #${config.stylix.base16Scheme.base0B};
        border-radius: 15px;
        margin: 5px;
        padding: 2px 10px;
      }
    '';
  };
}
