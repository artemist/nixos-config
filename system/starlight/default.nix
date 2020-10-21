{ config, pkgs, ... }:

{
  imports = [
    ./boot-config.nix
    ./hardware-configuration.nix
    ../../services/ssh.nix
    ../../private/starlight.nix
  ];

  networking.hostName = "starlight";

  services.udev.extraRules = ''
      KERNEL=="eth*", ATTR{address}=="00:0f:53:16:15:9c", NAME="lan10g0"
      KERNEL=="eth*", ATTR{address}=="00:0f:53:16:15:9d", NAME="lan10g1"
  '';

  hardware.cpu.amd.updateMicrocode = true;
  services = {
    tor = {
      enable = true;
      client.enable = true;
    };
  };

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  environment.systemPackages = with pkgs; [
    weechat
    steam

    gnome3.zenity
    SDL2 SDL2_ttf SDL2_image
  ];

  system.stateVersion = "19.09";
}
