{ pkgs, ... }:

{
  services = {
    keybase.enable = true;
    kbfs.enable = true;
  };

  environment.systemPackages = with pkgs; [ keybase-gui ];
}
