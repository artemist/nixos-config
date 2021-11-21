{ config, pkgs, lib, ... }:

{
  nix = {
    autoOptimiseStore = true;
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
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
      extraGroups = [ "wheel" "artemis" ];
      shell = pkgs.fish;
      # hashedPassword set in private
    };
    groups.artemis.gid = config.users.users.artemis.uid;
    mutableUsers = false;
  };
  systemd.extraConfig = "DefaultLimitCORE=infinity";
  security.pam.loginLimits = [{ domain = "*"; item = "core"; type = "hard"; value = "infinity"; }];
}