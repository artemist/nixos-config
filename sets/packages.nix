{ pkgs, lib, ... }: {
  environment.systemPackages = (with pkgs; [
    # Audiovisual
    darktable
    exiftool
    flac
    lame
    opusTools
    pavucontrol
    r128gain
    simple-scan
    skanlite
    yt-dlp

    # Linux tools
    dmidecode
    gparted
    hdparm
    iptables
    lm_sensors
    man-pages
    nethogs
    nvme-cli
    parted
    pinentry-curses
    pinentry-gtk2 # needed for tomb
    powertop
    psmisc
    qrencode
    rsync
    xorg.xeyes
    xorg.xkill
    zbar

    # Filesystems
    cifs-utils
    nfs-utils
    ntfs3g
    udftools

    # Useful CLI tools
    appimage-run
    bind
    borgbackup
    file
    fzf
    git-lfs
    gitAndTools.gitFull
    gitAndTools.pass-git-helper
    htop
    hunspell
    jq
    libarchive
    lsof
    nix-index
    openssl
    p7zip
    parallel
    pciutils
    pdftk
    poppler_utils
    python3Packages.ipython
    ripgrep
    rlwrap
    tmux
    tomb
    tree
    unrar
    unzip
    usbutils
    xxd
    zip

    # Coreutils replacements
    bat
    eza

    # Networking
    curlFull
    iw
    magic-wormhole
    mosh
    mtr
    sshuttle
    traceroute
    transmission-remote-gtk
    wget

    # Development
    patchelf
    rustup

    # Security
    pass
    wireguard-tools
    yubikey-manager

    # GUI tools
    alacritty
    evince
    gnome3.eog
    gnome3.gnome-system-monitor
    libreoffice-fresh
    nheko
    qalculate-gtk
    libqalculate

    # Web
    firefox-bin
    google-chrome

    # Gnome configuration
    gnome3.adwaita-icon-theme
    gsettings-desktop-schemas
    gnome-themes-extra
    hicolor-icon-theme

    # Dictionaries
  ]) ++ (with pkgs.hunspellDicts; [ en-us-large de_DE ])
    ++ (lib.optionals (pkgs.system == "x86_64-linux") (with pkgs; [
      efibootmgr
      efitools
      sbsigntool

      # Wine and tools
      cabextract
      samba
      wineWowPackages.waylandFull
    ]));
}
