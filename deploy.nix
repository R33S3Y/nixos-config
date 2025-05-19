{
  deploy.nodes = {
    diamond = {
      hostname = "diamond";  # Change to your real hostname or IP
      sshUser = "reese";            # Or your user with NixOS rebuild rights
      profiles.system = {
        user = "reese";
        path = ./#diamond;
      };
    };

    obsidian = {
      hostname = "obsidian"; # Change this too
      sshUser = "reese";
      profiles.system = {
        user = "reese";
        path = ./#obsidian;
      };
    };
  };

  deploy.defaults = {
    magicRollback = true;
    autoRollback = true;
  };
}
