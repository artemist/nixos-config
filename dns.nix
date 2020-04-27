{ config, pkgs, lib, ... }:

{
  networking = {
    resolvconf.useLocalResolver = true;
    networkmanager.dns = "none";
  };

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v2/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v2/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };

      server_names = ["cloudflare"];
      fallback_resolvers = ["1.1.1.1:53" "8.8.8.8:53"];

      listen_addresses = ["0.0.0.0:53"];
    };
  };
  systemd.services.dnscrypt-proxy2.serviceConfig.StateDirectory = "dnscrypt-proxy2";
}
