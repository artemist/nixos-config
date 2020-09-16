{ config, pkgs, ... }:

{
  imports = [
    ./boot-config.nix
    ./hardware-configuration.nix
    ../../services/ssh.nix
    ../../private/starlight.nix
  ];

  networking.hostName = "starlight";

  hardware.cpu.amd.updateMicrocode = true;
  services = {
    tor = {
      enable = true;
      client.enable = true;
    };
  };

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  environment.systemPackages = with pkgs; [
    steam

    gnome3.zenity
    SDL2 SDL2_ttf SDL2_image
  ];

  system.stateVersion = "19.09";
}
