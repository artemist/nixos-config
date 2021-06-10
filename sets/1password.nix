{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    _1password
    _1password-gui
  ];
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
}

