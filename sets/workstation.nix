{ config, pkgs, ... }:

{
  imports = [
    ./sway.nix
    ./packages.nix
    ./pipewire.nix
    ./neovim
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
    kbfs.enable = true;
    keybase.enable = true;
    pcscd.enable = true;
    syncthing = {
      enable = true;
      user = "artemis";
      dataDir = "/home/artemis";
    };
    udev.packages = [
      (pkgs.callPackage ../externals/rules/uhk.nix { })
    ];
  };

  hardware = {
    bluetooth.enable = true;
    opengl.driSupport32Bit = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
