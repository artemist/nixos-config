{ config, pkgs, ... }:
{
  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver
    intel-compute-runtime
  ];
  environment.systemPackages = with pkgs; [
    intel-gpu-tools
  ];
}
