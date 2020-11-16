{ config, pkgs, ... }:

{
  hardware.opengl.extraPackages = with pkgs; [
    vaapiVdpau
    libvdpau-va-gl
    rocm-opencl-icd
    rocm-runtime
  ];
  environment.systemPackages = [ pkgs.rocm-smi ];
}
