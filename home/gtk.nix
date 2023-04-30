{ ... }:
let
  common-gtk = {
    gtk-application-prefer-dark-theme = true;
  };
in
{
  home.sessionVariables.GTK_THEME = "Adwaita:dark";
  gtk = {
    enable = true;
    gtk3.extraConfig = common-gtk;
    gtk4.extraConfig = common-gtk;
  };
}
