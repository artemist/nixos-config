{ writeTextFile }:

writeTextFile {
  name = "cm-rgb-udev-rules";
  text = builtins.readFile ./cm-rgb.rules;
  destination = "/etc/udev/rules.d/60-cm-rgb.rules";
}
