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
    verilator
    # Programming
    dfu-util
    tinyprog
    wishbone-tool
    openfpgaloader
    (callPackage ../externals/packages/fujproj { })
  ];
}
