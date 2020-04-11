{ writeTextFile }:

writeTextFile {
  name = "limesuite-udev-rules";
  text = builtins.readFile ./limesuite.rules;
  destination = "/etc/udev/rules.d/64-limesuite.rules";
}
