{ config, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
  };
  # users.users.artemis.openssh.authorizedKeys.keys set in private
}
