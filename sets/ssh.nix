{ config, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };
  # users.users.artemis.openssh.authorizedKeys.keys set in private
}
