{ config, pkgs, ... }:
let
  llvm = pkgs.llvmPackages_12;
  ffmpeg-nonfree = pkgs.ffmpeg-full.override { nonfreeLicensing = true; fdkaacExtlib = true; };
  mpv = pkgs.wrapMpv (pkgs.mpv-unwrapped.override { ffmpeg = ffmpeg-nonfree; }) { };
  firefox = (pkgs.firefox-bin.override { forceWayland = true; });
in
{
  environment.systemPackages = (with pkgs; [
    # Audiovisual
    darktable
    exiftool
    ffmpeg-nonfree
    flac
    gimp
    inkscape
    lame
    mpv
    obs-studio
    opusTools
    pamixer
    pavucontrol
    sox
    vlc_qt5
    youtubeDL

    # Books
    calibre

    # Wine and tools
    cabextract
    samba
    wineWowPackages.staging

    # Virtualization
    docker-compose
    qemu

    # Linux tools
    dmidecode
    efibootmgr
    efitools
    gparted
    hdparm
    iptables
    lm_sensors
    manpages
    nethogs
    nvme-cli
    parted
    pinentry-curses
    pinentry-gtk2 # needed for tomb
    powertop
    psmisc
    qrencode
    rsync
    sbsigntool
    xorg.xeyes
    xorg.xkill
    zbar

    # Filesystems
    cifs_utils
    nfsUtils
    ntfs3g
    udftools

    # Useful CLI tools
    age
    appimage-run
    bat
    bind
    borgbackup
    file
    fzf
    git-lfs
    gitAndTools.gitFull
    gitAndTools.pass-git-helper
    htop
    hunspell
    iw
    jq
    libarchive
    lsof
    mercurialFull
    neovim
    nix-index
    openssl
    p7zip
    pandoc
    parallel
    pciutils
    pdftk
    pijul
    poppler_utils
    ripgrep
    rlwrap
    signify
    subversion
    tmux
    tomb
    traceroute
    tree
    unrar
    unzip
    usbutils
    xclip
    xxd
    zip

    # Networking
    curlFull
    httpie
    iodine
    magic-wormhole
    megatools
    mosh
    sshfs
    sshuttle
    transmission-gtk
    transmission-remote-gtk
    wget

    # Development
    binutils-unwrapped
    ccache
    clang-tools
    cmake
    conda
    gcc9
    gdb
    gnumake
    llvm.bintools
    llvm.clang
    llvm.lld
    nasm
    patchelf
    rustup
    valgrind
    yarn

    # Security
    (pass.withExtensions (exts: [ exts.pass-otp ]))
    keybase-gui
    wireguard
    yubikey-manager
    yubioath-desktop

    # GUI tools
    alacritty
    evince
    gnome3.eog
    gnome3.gnome-system-monitor
    libreoffice-fresh
    zathura

    # Web
    chromium
    firefox-wayland

    # Communication
    signal-desktop
    tdesktop

    # Gnome configuration
    gnome3.adwaita-icon-theme
    gnome3.gnome-tweak-tool
    gnome3.gsettings-desktop-schemas
    gnomeExtensions.appindicator
    gnome_themes_standard
    hicolor-icon-theme
    numix-icon-theme
    numix-icon-theme-circle

    # Dictionaries
  ]) ++ (with pkgs.hunspellDicts; [
    en-us-large
    de_DE
  ]);
}
