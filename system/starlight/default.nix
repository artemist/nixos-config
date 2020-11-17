{ config, pkgs, lib, ... }:

{
  imports = [
    ./boot-config.nix
    ./hardware-configuration.nix
    ./nginx.nix
    ../../private/starlight.nix
    ../../sets/cpu/amd.nix
    ../../sets/fpga.nix
    ../../sets/gpu/amd.nix
    ../../sets/hacking.nix
    ../../sets/hardware.nix
    ../../sets/neovim
    ../../sets/ssh.nix
    ../../sets/sway.nix
    ../../sets/virtualization.nix
  ];

  networking.hostName = "starlight";

  services.udev.extraRules = ''
      KERNEL=="eth*", ATTR{address}=="00:0f:53:16:15:9c", NAME="lan10g0"
      KERNEL=="eth*", ATTR{address}=="00:0f:53:16:15:9d", NAME="lan10g1"
  '';

  networking.bridges.br0 = {
    rstp = true;
    interfaces = [ "lan10g0" "lan10g1" "enp4s0" ];
  };
  networking.interfaces.br0 = {
    useDHCP = true;
    ipv6.addresses = [{
      address = "2001:470:8b04:6900:6969:1454:7749:e591";
      prefixLength = 128;
    }];
  };
  networking.dhcpcd.allowInterfaces = [ "br0" ];

  services.tor = {
    enable = true;
    client.enable = true;
  };

  boot.binfmt.emulatedSystems = [ "aarch64-linux" "riscv64-linux" ];

  environment.systemPackages = with pkgs; [
    weechat
    steam

    gnome3.zenity
    SDL2 SDL2_ttf SDL2_image
  ];

  system.stateVersion = "19.09";
}
