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
    
    
    # Optional settings
    privacyLevel = 0; # 0 = show everything, increase for more privacy
    queryLogDeleter = {
      enable = true;
      interval = "weekly";
      age = 7;      # keep logs max 7 days
    };

    settings = {
      dns = {
        domainNeeded = true;
        expandHosts = true;
        #listeningMode = "BIND";
        upstreams = [ "1.1.1.1" ];
      };
      dhcp = {
        active = true;
        router = "192.168.1.1";
        start = "192.168.1.2";
        end = "192.168.1.230";
        leaseTime = "1d";
        ipv6 = true;
        multiDNS = true;
        rapidCommit = true;
      };
      #misc.dnsmasq_lines = [
        # This DHCP server is the only one on the network
        #"dhcp-authoritative"
        # Source: https://data.iana.org/root-anchors/root-anchors.xml
        #"trust-anchor=.,38696,8,2,683D2D0ACB8C9B712A1948B27F741219298D0A450D612C483AF444A4C0FB2B16"
      #];
    };
  };
}
