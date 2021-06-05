{ config, pkgs, lib, ... }:

{
  imports = [
    ./private
    ./system/current
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

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Etc/UTC";

  environment.shellAliases.cp = "cp --reflink=auto --sparse=always";

  services.resolved.extraConfig = "MulticastDNS=true";


  networking.firewall.enable = false;

  programs.fish.enable = true;

  users = {
    users.artemis = {
      isNormalUser = true;
      description = "Artemis Tosini";
      uid = 1000;
      extraGroups = [ "wheel" "users" ];
      group = "artemis";
      # hashedPassword set in private
    };
    groups.artemis.gid = config.users.users.artemis.uid;
    mutableUsers = false;
  };
  systemd.extraConfig = "DefaultLimitCORE=infinity";
  security.pam.loginLimits = [{ domain = "*"; item = "core"; type = "hard"; value = "infinity"; }];
}
