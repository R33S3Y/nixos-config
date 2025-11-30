{ config, pkgs, ... }:
{
  
  stylix.targets.firefox = {
    profileNames = ["default"];
    colorTheme.enable = true;
  };

  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        search = {
          force = true;
          default = "ddg";
        };
        extensions = {
          force = true;
          #autoDisableScopes = 0;
          packages = with pkgs.nur.repos.rycee.firefox-addons;[
            darkreader
            sponsorblock
            return-youtube-dislikes
            redirect-shorts-to-youtube
          ];
        };
        settings = {
          "extensions.autoDisableScopes" = 0;
        };
      };
    };
    /* ---- POLICIES ---- */
    # Check about:policies#documentation for options.
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value= true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "always"; # alternatives: "always" or "newtab"
      DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
      SearchBar = "unified"; # alternative: "separate"
    };
  };
}
