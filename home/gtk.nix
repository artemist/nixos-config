{ ... }:
let
  common-gtk = {
    gtk-application-prefer-dark-theme = 1;
  };
in
{
  gtk = {
    enable = true;
    gtk3.extraConfig = common-gtk;
    gtk4.extraConfig = common-gtk;
  };
}
