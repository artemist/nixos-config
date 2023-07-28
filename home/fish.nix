{ ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = "set -g -x GPG_TTY (tty)";
    shellAliases = {
      cat = "bat";
      ls = "exa";
      cp = "cp --reflink=auto --sparse=always";
      nix-fish = "nix-shell --command fish";
    };
  };
}
