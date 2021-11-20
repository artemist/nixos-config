{ stdenv
, lib
, writeScriptBin
, runtimeShell
, yubikey-manager
, wofi
, wl-clipboard
, gawk
, gnugrep
, coreutils
}:

writeScriptBin "ykclip-wofi" ''
  #! ${runtimeShell}
  PATH=${lib.makeBinPath [ yubikey-manager wofi wl-clipboard gawk gnugrep coreutils ]}
  set -euo pipefail

  ykman list --serials | grep $1 > /dev/null

  name=$(ykman -d $1 oath accounts list | wofi -k /dev/null -i -d)

  line=$(ykman -d $1 oath accounts code "$name" | head -n 1)
  if test -n "$line"
  then
    echo $line | awk '{print $NF}' | wl-copy
  fi
''
