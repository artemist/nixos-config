{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [ (import ./externals/nixos-rocm) ];
  hardware.opengl.extraPackages = [ pkgs.rocm-opencl-icd ];
}
