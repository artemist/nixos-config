{ writeTextFile }:

writeTextFile {
  name = "uhk-udev-rules";
  text = builtins.readFile ./uhk.rules;
  destination = "/etc/udev/rules.d/69-uhk.rules";
}
