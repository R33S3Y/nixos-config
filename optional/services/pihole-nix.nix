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
    openFirewallDNS = true;
    openFirewallWebserver = true;
    
    /**
    # Blocklists
    lists = [
      {
        url = "https://easylist.to/easylist/easylist.txt";
        type = "block";
        enabled = true;
        description = "EasyList";
      }
      {
        url = "https://easylist.to/easylist/easyprivacy.txt";
        type = "block";
        enabled = true;
        description = "EasyPrivacy";
      }
      {
        url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
        type = "block";
        enabled = true;
        description = "Steven Black Hosts";
      }
    ];
    */
    
    # Optional settings
    privacyLevel = 0; # 0 = show everything, increase for more privacy
    queryLogDeleter = {
      enable = true;
      interval = "weekly";
      age = 7;      # keep logs max 7 days
    };
  };
}
