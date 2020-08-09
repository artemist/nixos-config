{ writeTextFile }:

writeTextFile {
  name = "ds4drv-udev-rules";
  text = builtins.readFile ./ds4drv.rules;
  destination = "/etc/udev/rules.d/50-ds4drv.rules";
}
