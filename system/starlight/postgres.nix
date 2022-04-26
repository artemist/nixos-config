{ config, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_14;
    extraPlugins = with config.services.postgresql.package.pkgs; [ postgis ];

    ensureDatabases = [ "osm" ];
    ensureUsers = [{
      name = "artemis";
      ensurePermissions = {
        "DATABASE osm" = "ALL PRIVILEGES";
      };
    }];
  };
}
