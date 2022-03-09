{ config, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./sway.nix
    ./packages.nix
    ./pipewire.nix
    ./base.nix
    ../home
  ];

  i18n.defaultLocale = "de_DE.UTF-8";

  environment = {
    variables.EDITOR = "nvim";
    variables.TERMINAL = "alacritty";
    variables.OCL_ICD_VENDORS = "/run/opengl-driver/etc/OpenCL/vendors";
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

  programs.ssh.startAgent = true;

  hardware = {
    bluetooth.enable = true;
    opengl.driSupport32Bit = (pkgs.system == "x86_64-linux");
    steam-hardware.enable = true;
    sane = {
      enable = true;
      brscan5.enable = true;
    };
  };

  nixpkgs.overlays = [
    (final: prev: {
      brscan5 = pkgs-unstable.brscan5;
    })
  ];

  users.users.artemis.extraGroups = [ "scanner" ];
}
