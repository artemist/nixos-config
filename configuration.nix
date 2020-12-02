{ config, pkgs, lib, ... }:

{
  imports = [
    ./private
    ./system/current
    ./packages.nix
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

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Etc/UTC";

  environment = {
    variables.TERMINAL = "alacritty";
    enableDebugInfo = true;
  };

  services = {
    avahi = {
      enable = true;
      nssmdns = true;
    };
    chrony.enable = true;
    flatpak.enable = true;
    fwupd.enable = true;
    kbfs.enable = true;
    keybase.enable = true;
    pcscd.enable = true;
    syncthing = {
      enable = true;
      user = "artemis";
      dataDir = "/home/artemis";
    };
    udev.packages = [
      (pkgs.callPackage ./externals/rules/uhk.nix { })
    ];
    printing = {
      enable = true;
      drivers = [
        (pkgs.brlaser.overrideAttrs (old: {
          patches = [
            (pkgs.fetchpatch {
              name = "l2300d-fix.patch";
              url = "https://patch-diff.githubusercontent.com/raw/pdewacht/brlaser/pull/68.patch";
              sha256 = "07iqv048q0iplghn0aamjslyixw1p5jbk004i20xnl1vs95nyqzy";
            })
          ];
        }))
      ];
    };
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

  networking.firewall.enable = false;

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    fish.enable = true;
  };

  users = {
    users.artemis = {
      isNormalUser = true;
      description = "Artemis Tosini";
      uid = 1000;
      extraGroups = [ "wheel" ];
      group = "artemis";
      # hashedPassword set in private
    };
    groups.artemis.gid = config.users.artemis.uid;
    mutableUsers = false;
  };
  systemd.extraConfig = "DefaultLimitCORE=infinity";
  security.pam.loginLimits = [{ domain = "*"; item = "core"; type = "hard"; value = "infinity"; }];
}
