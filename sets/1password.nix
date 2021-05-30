{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (_1password-gui.override { electron_11 = electron_12; })
  ];
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
}

