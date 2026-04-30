{ ... }:
{
  services.knot = {
    enable = true;
    checkConfig = true;

    settings = {

      server = {
        listen = [
          "0.0.0.0@53"
          "::@53"
        ];
      };

      zone = [{
        domain = "reesey.org";
        storage =
      }];
    };
  };
}
