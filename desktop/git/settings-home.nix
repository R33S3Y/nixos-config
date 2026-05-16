{ system, ... }:
{
  programs.git = {
    enable = true;
    settings = [
      {
        user = {
          email = system.users.${system.user}.email;
          name = system.users.${system.user}.prettyName;
        };
      }
    ];
  };
}
