{ pkgs, ... }:

{
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
