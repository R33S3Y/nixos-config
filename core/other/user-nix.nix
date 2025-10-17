{ config, pkgs, ... }:
let username = config.var.username;
in {
  users.users = {
    ${username} = {
      isNormalUser = true;
      uid = 1000;
      description = "${username}";
      extraGroups = [ "networkmanager" "wheel" ];
    };
    rebuild = {
      isNormalUser = true;
      uid = 1001;
      description = "Remote rebuild user";
      createHome = false; # or true if you want one
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAA..." ];
    };
  };
}