{ pkgs, ... }:

{
  programs._1password-gui = {
    enable = true;
    package = pkgs._1password-gui;
    polkitPolicyOwners = [ "artemis" ];
  };
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
}

