# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./private
      ./system/current
      ./packages.nix
      ./fonts.nix
      ./sets/neovim.nix
    ];

    nix = {
      daemonNiceLevel = 5;
      daemonIONiceLevel = 1;
      autoOptimiseStore = true;
      gc = {
        automatic = true;
        dates = "00:00";
        options = "--delete-older-than 14d";
      };
      trustedUsers = [ "artemis" ];
    };

    console = {
      keyMap = "us";
      earlySetup = true;
    };

    i18n.defaultLocale = "de_DE.UTF-8";

    nixpkgs = {
      config.allowUnfree = true;
    };

    time.timeZone = "Etc/UTC";

    environment = {
      variables = {
        TERMINAL = "alacritty";

      # for Sway
      MOZ_USE_XINPUT2 = "1";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      GTK_THEME = "Adwaita-dark";
    };
    enableDebugInfo = true;
    shellAliases = {
      vim = "nvim";
    };
  };

  sound.enable = true;

  virtualisation = {
    docker.enable = true;
    lxd = {
      enable = true;
      recommendedSysctlSettings = true;
    };
  };

  security.polkit.enable = true;

  services = {
    avahi = {
      enable = true;
      nssmdns = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };
    accounts-daemon.enable = true;
    chrony.enable = true;
    flatpak.enable = true;
    fwupd.enable = true;
    kbfs.enable = true;
    keybase.enable = true;
    logind.extraConfig = "HandlePowerKey=suspend";
    pcscd.enable = true;
    tor = {
      enable = true;
      client.enable = true;
    };
    syncthing = {
      enable = true;
      user = "artemis";
      dataDir = "/home/artemis";
    };
    udev.packages = [
      pkgs.android-udev-rules
      (pkgs.callPackage ./externals/rules/adafruit.nix { })
      (pkgs.callPackage ./externals/rules/fpga.nix { })
      (pkgs.callPackage ./externals/rules/limesuite.nix { })
      (pkgs.callPackage ./externals/rules/uhk.nix { })
    ];
    printing = {
      enable = true;
      drivers = [ pkgs.brlaser ];
    };
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };

  hardware = {
    bluetooth.enable = true;
    opengl.driSupport32Bit = true;
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      support32Bit = true;
      daemon.config.flat-volumes = "no";
    };
  };

  networking = {
    firewall.enable = false;
    networkmanager = {
      enable = lib.mkDefault true;
      ethernet.macAddress = "random";
      wifi.macAddress = "random";
    };
  };

  programs = {
    adb.enable = true;
    java = {
      enable = true;
      package = pkgs.adoptopenjdk-bin;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
    wireshark = {
      enable = true;
      package = pkgs.wireshark-qt;
    };
    fish.enable = true;
  };

  users = {
    users.artemis = {
      isNormalUser = true;
      description = "Artemis Tosini";
      uid = 1000;
      extraGroups = [ "networkmanager" "wheel" "adbusers" "wireshark" "video" "docker" "lxd" "plugdev" "dialout" ];
      # hashedPassword set in private
    };
    extraGroups.plugdev = {};
    users.root = {
      subUidRanges = [ { startUid = 16777216; count = 16777216; } { startUid = config.users.users.artemis.uid; count = 1; } ];
      subGidRanges = [ { startGid = 16777216; count = 16777216; } { startGid = 100; count = 1; } ];
    };
    mutableUsers = false;
  };
  systemd.extraConfig = "DefaultLimitCORE=infinity";
  security.pam.loginLimits = [ { domain = "*"; item = "core"; type = "hard"; value = "infinity"; } ];
}
