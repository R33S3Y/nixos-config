{
  services.pihole-web = {
    enable = true;
    ports = [
      "80r"
      "443s"
    ];
  };
  services.pihole-ftl = {
    enable = true;

    openFirewallDHCP = true;
    openFirewallWebserver = true;
    
    # Blocklists
    lists = [
      {
        url = "https://easylist.to/easylist/easylist.txt";
        type = "hosts";
        enabled = true;
        description = "EasyList";
      }
      {
        url = "https://easylist.to/easylist/easyprivacy.txt";
        type = "hosts";
        enabled = true;
        description = "EasyPrivacy";
      }
      {
        url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
        type = "hosts";
        enabled = true;
        description = "Steven Black Hosts";
      }
    ];
  
    # Optional settings
    privacyLevel = 0; # 0 = show everything, increase for more privacy
    queryLogDeleter = {
      enable = true;
      interval = "1d"; # delete logs older than 1 day
      age = "7d";      # keep logs max 7 days
    };

    # Web UI password can be set in settings if supported, otherwise set manually
    # settings = { WEBPASSWORD = "yourpassword"; };
  };

  #networking.firewall.allowedTCPPorts = [ 53 80 ];
  #networking.firewall.allowedUDPPorts = [ 53 ];
}
