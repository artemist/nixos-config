{ writeTextFile }:

writeTextFile {
  name = "m1n1-udev-rules";
  text = builtins.readFile ./m1n1.rules;
  destination = "/etc/udev/rules.d/80-m1n1.rules";
}
