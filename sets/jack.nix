{ pkgs, ... }:

{
  services.jack.jackd = {
    enable = true;
    extraOptions = [ "-dalsa" "--device" "hw:USB" ];
  };
  users.users.artemis.extraGroups = [ "jackaudio" ];
  environment.systemPackages = with pkgs; [
    qjackctl
  ];
}
