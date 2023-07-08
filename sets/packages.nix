{ config, pkgs, pkgs-unstable, lib, ... }:
{
  environment.systemPackages = (with pkgs; [
    # Audiovisual
    pkgs-unstable.darktable
    exiftool
    flac
    lame
    opusTools
    pavucontrol
    r128gain
    simple-scan
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
    bat
    bind
    borgbackup
    file
    fzf
    git-lfs
    gitAndTools.gitFull
    gitAndTools.pass-git-helper
    gnupg
    htop
    hunspell
    jq
    libarchive
    lsof
    neovim
    nix-index
    openssl
    p7zip
    parallel
    pciutils
    pdftk
    poppler_utils
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
    (pass.withExtensions (exts: [ exts.pass-otp ]))
    wireguard-tools
    yubikey-manager
    yubioath-flutter

    # GUI tools
    alacritty
    evince
    gnome3.eog
    gnome3.gnome-system-monitor
    libreoffice-fresh

    # Web
    firefox-bin
    google-chrome

    # Gnome configuration
    gnome3.adwaita-icon-theme
    gsettings-desktop-schemas
    gnome-themes-extra
    hicolor-icon-theme

    # Dictionaries
  ]) ++ (with pkgs.hunspellDicts; [
    en-us-large
    de_DE
  ]) ++ (lib.optionals (pkgs.system == "x86_64-linux") (with pkgs; [
    efibootmgr
    efitools
    sbsigntool

    # Wine and tools
    cabextract
    samba
    pkgs-unstable.wineWowPackages.waylandFull
  ]));
}
