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
    ./tpm2.nix
    ./secure-boot.nix
    ./fonts.nix
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

  security.polkit.enable = true;

  services = {	
    avahi = {
      enable = true;
      nssmdns = true;
    };
    accounts-daemon.enable = true;
    chrony.enable = true;
    flatpak.enable = true;
    fwupd.enable = true;
    kbfs.enable = true;
    keybase.enable = true;
    logind.extraConfig = "HandlePowerKey=suspend";
    pcscd.enable = true;
    throttled.enable = true;
    tlp.enable = true;
    upower.enable = true;
    syncthing = {
      enable = true;
      user = "artemis";
      dataDir = "/home/artemis";
    };
    printing = {
      enable = true;
      browsedConf = "BrowseProtocols none";
      drivers = with pkgs; [ gutenprint gutenprintBin ];
    };
  };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  hardware = {	
    cpu.intel.updateMicrocode = true;
    sensor.iio.enable = true;
    bluetooth.enable = true;
    opengl = {	
      extraPackages = with pkgs; [
        intel-media-driver
        libvdpau-va-gl
        vaapiIntel
        vaapiVdpau
      ];
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
    hostName = "rainbowdash";
    firewall.enable = false;
    networkmanager = {
      enable = true;
      ethernet.macAddress = "random";
      wifi.macAddress = "random";
    };
  };

  programs = {
    adb.enable = true;
    firejail.enable = true;
    fish.enable = true;
    light.enable = true;
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
  };

  users = {
    users.artemis = {
      isNormalUser = true;
      description = "Artemis Tosini";
      uid = 1000;
      shell = "/run/current-system/sw/bin/fish";
      extraGroups = [ "networkmanager" "wheel" "adbusers" "wireshark" "video" "docker" "lxd" "plugdev" "dialout"];
      # hashedPassword set in private
    };
    extraGroups.plugdev = { };
    users.root = {
      subUidRanges = [ { startUid = 16777216; count = 16777216; } { startUid = config.users.users.artemis.uid; count = 1; } ];
      subGidRanges = [ { startGid = 16777216; count = 16777216; } { startGid = 100; count = 1; } ];
    };
    mutableUsers = false;
  };
  systemd.extraConfig = "DefaultLimitCORE=infinity";
  security.pam.loginLimits = [ { domain = "*"; item = "core"; type = "hard"; value = "infinity"; } ];

  system.stateVersion = "20.03";

}
