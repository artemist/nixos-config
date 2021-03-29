{ writeTextFile }:

writeTextFile {
  name = "steam-udev-rules";
  text = builtins.readFile ./steam-input.rules;
  destination = "/etc/udev/rules.d/60-steam-input.rules";
}
