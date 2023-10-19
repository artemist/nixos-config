{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./boot-config.nix
    ./hardware-configuration.nix
    ./scripts.nix
    ../../sets/1password.nix
    ../../sets/builder.nix
    ../../sets/disc.nix
    ../../sets/fpga.nix
    ../../sets/hacking.nix
    ../../sets/hardware.nix
    ../../sets/krb5.nix
    ../../sets/music.nix
    ../../sets/radio.nix
    ../../sets/secureBoot.nix
    ../../sets/sshd.nix
    ../../sets/virtualization.nix
    ../../sets/workstation.nix
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
  ];

  # Network
  networking.hostName = "starlight";
  services.udev.extraRules = ''
    KERNEL=="eth*", ATTR{address}=="00:0f:53:16:15:9c", NAME="lan10g0"
    KERNEL=="eth*", ATTR{address}=="00:0f:53:16:15:9d", NAME="lan10g1"
    KERNEL=="eth*", ATTR{address}=="b4:2e:99:3d:07:66", NAME="lan1g0"

    SUBSYSTEM=="usb", ATTR{idVendor}=="057e", ATTR{idProduct}=="3000", TAG+="uaccess", TAG+="udev-acl"
  '';

  networking.useDHCP = false;

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

  networking.vlans."br0.5" = {
    id = 5;
    interface = "br0";
  };
  networking.bridges.brvm = {
    rstp = false;
    interfaces = [ "br0.5" ];
  };

  networking.vlans."br0.4" = {
    id = 4;
    interface = "br0";
  };
  networking.bridges.briot = {
    rstp = false;
    interfaces = [ "br0.4" ];
  };

  services.openssh.extraConfig = ''
    HostCertificate ${./starlight-cert.pub}
  '';

  # Filesystems
  services.btrfs.autoScrub = {
    enable = true;
    fileSystems = [ "/" "/media/data" ];
  };

  # Skye user for luna
  users.users.skye = {
    isSystemUser = true;
    uid = 1001;
    group = "users";
  };

  # Packages
  boot.binfmt.emulatedSystems = [ "aarch64-linux" "riscv64-linux" ];

  services.printing.drivers = [
    (pkgs.brlaser.overrideAttrs (old: {
      version = "unstable-2020-04-20";
      src = pkgs.fetchFromGitHub {
        owner = "pdewacht";
        repo = "brlaser";
        rev = "9d7ddda8383bfc4d205b5e1b49de2b8bcd9137f1";
        sha256 = "sha256-pNkwJKdKhBO8u97GyvfxmyisaqIkzuk5UslWdaYFMLc=";
      };
    }))
  ];

  services.udev.packages =
    [ (pkgs.callPackage ../../externals/rules/m1n1.nix { }) ];

  hardware.opengl.extraPackages = with pkgs; [ vulkan-validation-layers ];

  # Home
  home-manager.users.artemis = {
    programs.git.signing.key =
      lib.mkForce "3D2BB230F9FAF0C5183246DD4FDC96F161E7BA8A";
    programs.mpv.defaultProfiles = [ "gpu-hq" ];
    wayland.windowManager.sway.config.output = {
      "DP-1" = {
        pos = "0 0";
        mode = "3840x2160@59.997Hz";
        scale = "2";
      };
      "DP-2" = {
        pos = "1920 0";
        mode = "3840x2160@59.997Hz";
        scale = "2";
      };
      "DP-3" = {
        pos = "3840 0";
        mode = "3840x2160@60Hz";
        scale = "2";
      };
    };
    # no toTOML generator so I guess we have to do this
    xdg.configFile."rustybar/config.toml".text = ''
      [[tile]]
      type = "load"
      [[tile]]
      type = "memory"
      [[tile]]
      type = "hostname"
      [[tile]]
      type = "time"
      format = "%Y-%m-%dT%H:%M:%S"
    '';
    xdg.userDirs = {
      music = "/media/data/Musik";
      pictures = "/media/luna/photos";
    };
  };
  # NixOS
  system.stateVersion = "21.11";
}
