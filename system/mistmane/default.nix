{ config, pkgs, lib, ... }:

{
  imports = [
    ./boot-config.nix
    ./hardware-configuration.nix
    ../../externals/wip-pinebook-pro/pinebook_pro.nix
    ../../sets/laptop.nix
    ../../sets/workstation.nix
  ];

  networking.hostName = "mistmane";

  security.pam.enableEcryptfs = true;
  environment.systemPackages = with pkgs; [
    ecryptfs
    ecryptfs-helper
  ];

  home-manager.users.artemis = {
    programs.foot = {
      enable = true;
      settings.main = {
        shell = "/run/current-system/sw/bin/fish";
        font = "Fira Code:size=6";
      };
    };
    wayland.windowManager.sway.config = {
      terminal = lib.mkForce "foot";
      input."9610:30:HAILUCK_CO.,LTD_USB_KEYBOARD_Touchpad" = {
        middle_emulation = "enabled";
        click_method = "clickfinger";
      };
    };
    xdg.configFile."rustybar/config.toml".text = ''
      [[tile]]
      type = "iwd"
      interface = "wlan0"
      [[tile]]
      type = "load"
      [[tile]]
      type = "memory"
      [[tile]]
      type = "hostname"
      [[tile]]
      type = "battery"
      battery = "cw2015-battery"
      [[tile]]
      type = "time"
      format = "%Y-%m-%dT%H:%M:%S"
    '';
  };
  services.logind = {
    lidSwitch = lib.mkForce "lock";
    extraConfig = lib.mkForce "HandlePowerKey=lock";
  };

  system.stateVersion = "21.11";
}
