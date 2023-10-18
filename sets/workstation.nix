{ config, pkgs, ... }:

{
  imports = [
    ./sway.nix
    ./packages.nix
    ./pipewire.nix
    ./base.nix
    ./nvim.nix
    ../home
    ./nix-index.nix
  ];

  i18n.defaultLocale = "de_DE.UTF-8";
  i18n.supportedLocales = [ "all" ];

  environment = {
    variables.EDITOR = "nvim";
    variables.TERMINAL = "kitty";
    enableDebugInfo = true;
  };

  services = {
    avahi = {
      enable = true;
      nssmdns = true;
    };
    flatpak.enable = true;
    fwupd.enable = true;
    pcscd.enable = true;
    printing.enable = true;
    udev.packages = [ (pkgs.callPackage ../externals/rules/uhk.nix { }) ];
  };

  programs.ssh.startAgent = true;

  hardware = {
    bluetooth.enable = true;
    opengl.driSupport32Bit = (pkgs.system == "x86_64-linux");
    steam-hardware.enable = true;
    sane = {
      enable = true;
      brscan5.enable = (pkgs.system == "x86_64-linux");
    };
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };

  users.users.artemis.extraGroups = [ "scanner" ];
}
