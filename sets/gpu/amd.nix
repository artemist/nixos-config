{ config, pkgs, ... }:

{
  hardware.opengl.extraPackages = with pkgs; [
    rocm-opencl-icd
    rocm-runtime
  ];
  environment.systemPackages = [ pkgs.rocm-smi ];
}
