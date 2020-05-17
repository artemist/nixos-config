{ config, pkgs, ... }:

{
  imports = [ ./externals/systemd-boot-secure ];
  boot = {
    loader.systemd-boot-secure = {
      enable = true;
      signed = true;
      signing-key = "/root/secure-boot/db.key";
      signing-certificate = "/root/secure-boot/db.crt";
    };
  };
}
