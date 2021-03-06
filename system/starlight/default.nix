{ config, pkgs, lib, ... }:

{
  imports = [
    ./boot-config.nix
    ./hardware-configuration.nix
    ../../private/starlight.nix
    ../../sets/builder.nix
    ../../sets/cpu/amd.nix
    ../../sets/fpga.nix
    ../../sets/gpu/amd.nix
    ../../sets/hacking.nix
    ../../sets/hardware.nix
    ../../sets/krb5.nix
    ../../sets/printing.nix
    ../../sets/radio.nix
    ../../sets/ssh.nix
    ../../sets/virtualization.nix
    ../../sets/workstation.nix
    ../../sets/1password.nix
  ];

  # Network
  networking.hostName = "starlight";
  services.udev.extraRules = ''
    KERNEL=="eth*", ATTR{address}=="00:0f:53:16:15:9c", NAME="lan10g0"
    KERNEL=="eth*", ATTR{address}=="00:0f:53:16:15:9d", NAME="lan10g1"
    KERNEL=="eth*", ATTR{address}=="b4:2e:99:3d:07:66", NAME="lan1g0"
  '';
  networking.bridges.br0 = {
    rstp = true;
    interfaces = [ "lan10g0" "lan10g1" "lan1g0" ];
  };
  networking.interfaces.br0 = {
    useDHCP = true;
    ipv6.addresses = [{
      address = "2001:470:8b04:6900:6969:1454:7749:e591";
      prefixLength = 128;
    }];
  };
  networking.dhcpcd.allowInterfaces = [ "br0" ];


  # Filesystems
  boot.supportedFilesystems = [ "zfs" "btrfs" ];
  boot.zfs = {
    enableUnstable = true;
    forceImportAll = false;
    forceImportRoot = false;
    requestEncryptionCredentials = false;
  };
  services.btrfs.autoScrub = {
    enable = true;
    fileSystems = [ "/" "/media/data" "/media/archive" ];
  };

  # Skye user for luna
  users.users.skye = {
    isSystemUser = true;
    uid = 1001;
  };

  # Packages
  services.tor = {
    enable = true;
    client.enable = true;
  };
  boot.binfmt.emulatedSystems = [ "aarch64-linux" "riscv64-linux" ];
  environment.systemPackages = with pkgs; [
    (weechat.override {
      configure = { availablePlugins, ... }: {
        plugins = (builtins.attrValues availablePlugins);
        scripts = [ weechatScripts.weechat-matrix ];
      };
    })
  ];

  hardware.opengl.extraPackages = with pkgs; [ vulkan-validation-layers ];

  # Home
  home-manager.users.artemis.programs.mpv.defaultProfiles = [ "gpu-hq" ];

  # NixOS
  system.stateVersion = "19.09";
}
