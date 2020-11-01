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

    # CPU stuff
    pkgsCross.riscv64-embedded.buildPackages.binutils
    pkgsCross.riscv64-embedded.buildPackages.gcc
    pkgsCross.riscv32-embedded.buildPackages.binutils
    pkgsCross.riscv32-embedded.buildPackages.gcc
  ];
}
