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
        upstreams = [ "8.8.8.8" "8.8.4.4" ];
        CNAMEdeepInspect = true;
        blockESNI = true;
        EDNS0ECS = true;
        ignoreLocalhost = false;
        showDNSSEC = true;
        analyzeOnlyAandAAAA = false;
        piholePTR = "PI.HOLE";
        replyWhenBusy = "ALLOW";
        blockTTL = 2;
        hosts = [ ];
        domainNeeded = false;
        expandHosts = false;
        domain = "lan";
        bogusPriv = true;
        dnssec = false;
        interface = "ens18";
        hostRecord = "";
        listeningMode = "LOCAL";
        queryLogging = true;
        cnameRecords = [ ];
        port = 53;
        revServers = [ ];

        cache = {
          size = 10000;
          optimizer = 3600;
          upstreamBlockedTTL = 86400;
        };

        blocking = {
          active = true;
          mode = "NULL";
          edns = "TEXT";
        };

        specialDomains = {
          mozillaCanary = true;
          iCloudPrivateRelay = true;
          designatedResolver = true;

          reply = {
            host = {
              force4 = false;
              IPv4 = "";
              force6 = false;
              IPv6 = "";
            };
            blocking = {
              force4 = false;
              IPv4 = "";
              force6 = false;
              IPv6 = "";
            };
          };
        };

        rateLimit = {
          count = 1000;
          interval = 60;
        };
      };

      dhcp = {
        active = false;
        start = "";
        end = "";
        router = "";
        netmask = "";
        leaseTime = "";
        ipv6 = false;
        rapidCommit = false;
        multiDNS = false;
        logging = false;
        ignoreUnknownClients = false;
        hosts = [ ];
      };

      ntp = {
        ipv4 = {
          active = true;
          address = "";
        };
        ipv6 = {
          active = true;
          address = "";
        };
        sync = {
          active = true;
          server = "pool.ntp.org";
          interval = 3600;
          count = 8;
          rtc = {
            set = false;
            device = "";
            utc = true;
          };
        };
      };

      resolver = {
        resolveIPv4 = true;
        resolveIPv6 = true;
        networkNames = true;
        refreshNames = "IPV4_ONLY";
      };

      database = {
        DBimport = true;
        maxDBdays = 91;
        DBinterval = 60;
        useWAL = true;

        network = {
          parseARPcache = true;
          expire = 91;
        };
      };

      webserver = {
        domain = "pi.hole";
        acl = "";
        #port = "80o,443os,[::]:80o,[::]:443os";
        threads = 50;
        headers = [
          "X-DNS-Prefetch-Control: off"
          "Content-Security-Policy: default-src 'self' 'unsafe-inline';"
          "X-Frame-Options: DENY"
          "X-XSS-Protection: 0"
          "X-Content-Type-Options: nosniff"
          "Referrer-Policy: strict-origin-when-cross-origin"
        ];
        serve_all = false;

        session = {
          timeout = 1800;
          restore = true;
        };

        tls = {
          cert = "/etc/pihole/tls.pem";
        };

        paths = {
          webroot = "/var/www/html";
          webhome = "/admin/";
          prefix = "";
        };

        interface = {
          boxed = true;
          theme = "default-auto";
        };

        api = {
          max_sessions = 16;
          prettyJSON = false;
          pwhash = "$BALLOON-SHA256$v=1$s=1024,t=32$yIWL542L+LORQ6pzuDIEuA==$mdkGwgBJN0Zsy84SNqbfIzc3Gr+to7dz3Zx3q/FjiEY=";
          totp_secret = "";
          app_pwhash = "";
          app_sudo = false;
          cli_pw = true;
          excludeClients = [ ];
          excludeDomains = [ ];
          maxHistory = 86400;
          maxClients = 10;
          client_history_global_max = true;
          allow_destructive = true;

          temp = {
            limit = 60.0;
            unit = "C";
          };
        };
      };

      #files = {
      #  pid = "/run/pihole-FTL.pid";
      #  database = "/etc/pihole/pihole-FTL.db";
      #  gravity = "/etc/pihole/gravity.db";
      #  gravity_tmp = "/tmp";
      #  macvendor = "/etc/pihole/macvendor.db";
      #  pcap = "";
      #
      #  log = {
      #    ftl = "/var/log/pihole/FTL.log";
      #    dnsmasq = "/var/log/pihole/pihole.log";
      #    webserver = "/var/log/pihole/webserver.log";
      #  };
      #};

      misc = {
        privacylevel = 0;
        delay_startup = 0;
        nice = -10;
        addr2line = true;
        etc_dnsmasq_d = false;
        dnsmasq_lines = [ ];
        extraLogging = false;
        readOnly = false;

        check = {
          load = true;
          shmem = 90;
          disk = 90;
        };
      };

      debug = {
        database = false;
        networking = false;
        locks = false;
        queries = false;
        flags = false;
        shmem = false;
        gc = false;
        arp = false;
        regex = false;
        api = false;
        tls = false;
        overtime = false;
        status = false;
        caps = false;
        dnssec = false;
        vectors = false;
        resolver = false;
        edns0 = false;
        clients = false;
        aliasclients = false;
        events = false;
        helper = false;
        config = false;
        inotify = false;
        webserver = false;
        extra = false;
        reserved = false;
        ntp = false;
        netlink = false;
        all = false;
      };
    };
  };
}
