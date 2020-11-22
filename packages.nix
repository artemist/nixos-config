{ config, pkgs, ... }:

let
  llvm = pkgs.llvmPackages_10;
  go = pkgs.go_1_15;
in
  {
    environment.systemPackages = (with pkgs; [
    # Audiovisual
    audacity
    darktable
    exiftool
    ffmpeg-full
    flac
    gimp
    inkscape
    lame
    mpv
    obs-studio
    obs-wlrobs
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
    nix-index
    nixops
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
    go
    gopls
    llvm.clang
    llvm.lld
    nasm
    patchelf
    rustup
    valgrind
    yarn

    # Radio
    gr-limesdr
    limesuite
    gnuradio-with-packages
    soapysdr
    gqrx

    # Hacking tools

    # Security
    (pass.withExtensions (exts: [ exts.pass-otp ]))
    _1password
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
    discord
    signal-desktop
    slack
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

    # Games
    multimc
    steam-run

    # Dictionaries
  ]) ++ (with pkgs.hunspellDicts; [
    en-us-large
    de_DE
  ]);

  # Needed for obs-wlrobs
  environment.pathsToLink = [ "/share/obs" "share/kicad" ];
}
