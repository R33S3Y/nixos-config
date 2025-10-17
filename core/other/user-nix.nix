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
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPGspq2G8adszEonoETTJ9s8RWFCJfthqCqd5fjq+wXm r3es3y@gmail.com" ];
    };
  };
}