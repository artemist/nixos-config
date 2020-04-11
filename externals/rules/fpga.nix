{ writeTextFile }:

writeTextFile {
  name = "fpga-udev-rules";
  text = builtins.readFile ./fpga.rules;
  destination = "/etc/udev/rules.d/71-fpga.rules";
}
