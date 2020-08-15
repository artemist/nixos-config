{ config, pkgs, ... }:

{
  imports = [ ./boot-config.nix ./secure-boot.nix ./hardware-configuration.nix ];

  networking.hostName = "rainbowdash";

  hardware = {
    cpu.intel.updateMicrocode = true;
    opengl.extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
    ];
  };
  services = {
    tlp.enable = true;
    upower.enable = true;
    throttled.enable = true;
  };
}
