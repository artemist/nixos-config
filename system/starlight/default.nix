{ config, pkgs, ... }:

{
  imports = [ ./boot-config.nix ./hardware-configuration.nix ];

  networking.hostName = "starlight";

  hardware.cpu.amd.updateMicrocode = true;
  services = {
    tor = {
      enable = true;
      client.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    steam

    gnome3.zenity
    SDL2 SDL2_ttf SDL2_image
  ];

  system.stateVersion = "19.09";
}
