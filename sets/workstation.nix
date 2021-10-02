{ config, pkgs, ... }:

{
  imports = [
    ./sway.nix
    ./packages.nix
    ./pipewire.nix
    ../home
  ];

  i18n.defaultLocale = "de_DE.UTF-8";

  environment = {
    variables.TERMINAL = "alacritty";
    enableDebugInfo = true;
  };

  services = {
    flatpak.enable = true;
    fwupd.enable = true;
    pcscd.enable = true;
    printing.enable = true;
    udev.packages = [
      (pkgs.callPackage ../externals/rules/uhk.nix { })
    ];
  };

  hardware = {
    bluetooth.enable = true;
    opengl.driSupport32Bit = (builtins.currentSystem == "x86_64-linux");
    steam-hardware.enable = true;
  };
}
