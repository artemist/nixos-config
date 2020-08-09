# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./private
      ./hardware-configuration.nix
      ./boot-config.nix
      ./packages.nix
      ./fonts.nix
      ./ssh.nix
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
      MOZ_USE_XINPUT2 = "1";
      EDITOR = "nvim";
      TERMINAL = "kitty";
      _JAVA_AWT_WM_NONREPARENTING = "1";
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

  security = {
    pam = {
      u2f = {
        enable = true;
        authFile = "/etc/u2f_keys";
        cue = true;
      };
      services.swaylock.u2fAuth = false;
      services.i3lock.u2fAuth = false;
      services.login.u2fAuth = false;
      services.sytemd-user.u2fAuth = false;
      services.xlock.u2fAuth = false;
      services.xscreensaver.u2fAuth = false;
    };
    polkit.enable = true;
  };

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
    pipewire.enable = true;
    tor = {
      enable = true;
      client.enable = true;
    };
    syncthing = {
      enable = true;
      user = "artemis";
      dataDir = "/home/artemis";
    };
    printing = {
      enable = true;
      drivers = with pkgs; [ brlaser ];
    };
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      (callPackage ./externals/packages/xdg-desktop-portal-wlr.nix {})
    ];
  };

  hardware = {
    cpu.amd.updateMicrocode = true;
    bluetooth.enable = true;
    opengl = {
      extraPackages = [ pkgs.vaapiVdpau pkgs.libvdpau-va-gl ];
      driSupport32Bit = true;
    };
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      support32Bit = true;
      daemon.config.flat-volumes = "no";
    };
  };

  networking = {
    hostName = "starlight";
    firewall.enable = false;
    networkmanager = {
      enable = true;
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
    light.enable = true;
    wireshark = {
      enable = true;
      package = pkgs.wireshark-qt;
    };
    firejail.enable = true;
    fish.enable = true;
    xonsh = {
      # enable = true;
      package = pkgs.xonsh.overridePythonAttrs (
        old: {
          propagatedBuildInputs = old.propagatedBuildInputs ++ [ pkgs.python3Packages.nixpkgs ];
        }
      );
    };
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

  system.stateVersion = "19.03";

}
