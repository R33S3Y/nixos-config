
{ config, pkgs, inputs, ... }:

{
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
  
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 
      25565 
    ]; #minecraft java default server port
  };

  environment.systemPackages = with pkgs; [
    git # Needed for fastBackups 
    git-lfs # Also for fastBackups
  ];

  services.minecraft-servers = {
    enable = true;
    eula = true;

    user = "cms";
    group = "cms";

    servers = {
      cmsSurvival = {
        enable = true;
        package = pkgs.fabricServers.fabric-1_21_11;

        serverProperties = {
          difficulty = "hard";
          gamemode = "survival";
          view-distance = 16;
          simulation-distance = 16;
          motd = "§cChristian §9Minecraft §eServer§r§b - Creative Mode Soon?";
          level-name = "CMS"; 
        };

        jvmOpts = "-Xms4092M -Xmx4092M";

        symlinks = { 
          #Fetching from the internet
          "mods" = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
            lithium = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/gl30uZvp/lithium-fabric-0.21.2%2Bmc1.21.11.jar"; sha256 = "sha256-MQZjnHPuI/RL++Xl56gVTf460P1ISR5KhXZ1mO17Bzk="; };
            krypton = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/O9LmWYR7/krypton-0.2.10.jar"; sha256 = "sha256-lCkdVpCgztf+fafzgP29y+A82sitQiegN4Zrp0Ve/4s="; };
            c2me = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/VSNURh3q/versions/olrVZpJd/c2me-fabric-mc1.21.11-0.3.6.0.0.jar"; sha256 = "sha256-DwWNNWBfzM3xl+WpB3QDSubs3yc/NMMV3c1I9QYx3f8="; };
            carpet = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/TQTTVgYE/versions/HzPcczDK/fabric-carpet-1.21.11-1.4.194%2Bv251223.jar"; sha256 = "sha256-G01m8DMr2l3u4IdV5JPC1qxk1k1SheETSqA2BJdcJSE="; };
            fastBackups = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/ZHKrK8Rp/versions/yqaOm9Fj/fastback-0.30.0%2B1.21.11-fabric.jar"; sha256 = "sha256-/GEq3gC8QJdVbFrK5JcTQDmk+cuJX6kAkFOKfrDeEmk="; };
            fabricAPI = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/gB6TkYEJ/fabric-api-0.140.2%2B1.21.11.jar"; sha256 = "sha256-t8RYO3/EihF5gsxZuizBDFO3K+zQHSXkAnCUgSb4QyE="; };
            clothConfigAPI = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/9s6osm5g/versions/xuX40TN5/cloth-config-21.11.153-fabric.jar"; sha256 = "sha256-ikDITl7N5SWs+2xOE7gALaz8o++VNNf69ugEllb0I8g="; };
            distantHorizons = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/uCdwusMi/versions/GT3Bm3GN/DistantHorizons-2.4.5-b-1.21.11-fabric-neoforge.jar"; sha256 = "sha256-dpTHoX5V9b7yG0VsIqKxxOSAYLN0Z97itx1MEuWGvD8="; };
            noEndermanGrief = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/ss02V75k/versions/JsguYUrA/no-enderman-grief-v3.0.1.jar"; sha256 = "sha256-w5uz+6KMVO27pXxdW+Pu4tX4OtZLsgB08skETMn7Fj4="; };
          });
      
          "server-icon.png" = ./minecraftServerIcon.png;
        };
      };
    };
  };
}