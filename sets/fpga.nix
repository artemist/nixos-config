{ pkgs, ... }:

{
  services.udev.packages = [
    (pkgs.callPackage ../externals/rules/fpga.nix { })
  ];
  environment.systemPackages = with pkgs; [
    # Synthesis
    icestorm
    nextpnr
    trellis
    yosys
    # Testing
    ghdl
    symbiyosys
    verilog
    # Programming
    dfu-util
    tinyprog
    wishbone-tool
    ( callPackage ../externals/packages/fujproj { } )
  ];
}
