{ config, pkgs, inputs, ... }:

{
  imports = [
    ./boot-config.nix
    ./hardware-configuration.nix
    ../../sets/1password.nix
    ../../sets/buildMachines.nix
    ../../sets/hacking.nix
    ../../sets/laptop.nix
    ../../sets/secureBoot.nix
    ../../sets/sshd.nix
    ../../sets/workstation.nix
    inputs.nixos-hardware.nixosModules.gpd-micropc
  ];

  networking.hostName = "spike";
  system.stateVersion = "23.11";

  home-manager.users.artemis = {
    xdg.configFile."rustybar/config.toml".text = ''
      [[tile]]
      type = "load"
      [[tile]]
      type = "memory"
      [[tile]]
      type = "hostname"
      [[tile]]
      type = "battery"
      [[tile]]
      type = "time"
      format = "%Y-%m-%dT%H:%M:%S"
    '';

    wayland.windowManager.sway.config = {
      output."DSI-1" = {
        pos = "0 0";
        mode = "720x1280@60.083Hz";
        transform = "90";
      };
      input."24704:32865:AMR-4630-XXX-0-_0-1023_USB_KEYBOARD_Mouse" = {
        scroll_method = "on_button_down";
        scroll_button = "BTN_MIDDLE";
      };
    };
    xdg.userDirs.music = "/media/µsd/Musik";
  };
}
