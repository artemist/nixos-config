{ pkgs, config, ... }:

{
  security.acme = {
    acceptTerms = true;
    email = "me@artem.ist";
  };
  services.nginx = {
    enable = true;
    package = pkgs.nginxMainline;
    virtualHosts."starlight.manehattan.artem.ist" = {
      default = true;
      forceSSL = true;
      enableACME = true;
      root = "/srv/nginx/starlight.manehattan.artem.ist";
    };
  };
}
