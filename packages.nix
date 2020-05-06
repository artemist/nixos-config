{ config, pkgs, ... }:

let
  llvm = pkgs.llvmPackages_10;
  go = pkgs.go_1_14;
  unwrappedFirefox = pkgs.firefox-bin-unwrapped.override { systemLocale = "de-DE"; };
  fullFirefox = (pkgs.wrapFirefox unwrappedFirefox {
    browserName = "firefox";
    desktopName = "Firefox";
    gdkWayland = true;
    pname = "firefox-bin";
  });
in
  {
    environment.systemPackages = (with pkgs; [
    # Audiovisual
    audacity
    darktable
    ffmpeg-full
    flac
    gimp
    lame
    mpv
    opusTools
    pamixer
    pavucontrol
    sox
    vlc_qt5
    youtubeDL

    # Drawing and art
    krita
    xournal
    xournalpp

    # Books
    calibre

    # Emulation
    mgba
    mupen64plus

    # Wine and tools
    cabextract
    samba
    wineWowPackages.staging
    winetricks

    # Virtualization
    docker-compose
    gnome3.gnome-boxes
    qemu

    # Linux tools
    cachix
    dmidecode
    gparted
    hdparm
    i7z
    iptables
    krb5
    linuxPackages.cpupower
    lm_sensors
    manpages
    nethogs
    parted
    pinentry-gtk2 # needed for tomb
    powertop
    psmisc
    sbsigntool
    xorg.xeyes
    xorg.xkill

    # Filesystems
    cifs_utils
    exfat
    nfsUtils
    ntfs3g
    udftools

    # Wayland tools
    dex
    grim
    imagemagick
    mako
    polkit_gnome
    slurp
    wf-recorder
    wl-clipboard
    wofi
    xdg-user-dirs
    xdg_utils
    xsettingsd

    # Useful CLI tools
    appimage-run
    bat
    bind
    borgbackup
    exa
    file
    fzf
    git-lfs
    gitAndTools.gitFull
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
    parallel
    p7zip
    pandoc
    pciutils
    pdftk
    poppler_utils
    ripgrep
    rlwrap
    subversion
    tmux
    tomb
    traceroute
    tree
    unzip
    usbutils
    xclip
    xxd
    ytop
    zip
    
    # Networking
    curlFull
    httpie
    iodine
    megatools
    mosh
    sshfs
    sshuttle
    transmission-gtk
    transmission-remote-gtk
    wget

    # Development
    arduino
    binutils-unwrapped
    ccache
    clang-tools
    cmake
    conda
    gcc9
    gdb
    gnumake
    go
    jetbrains.clion
    llvm.clang
    llvm.lld
    nasm
    patchelf
    python37Packages.python-language-server
    rr
    rustup
    valgrind
    vscode

    # Hardware
    arachne-pnr
    eagle
    icestorm
    kicad
    nextpnr
    tinyprog
    verilator
    verilog
    yosys

    # Radio
    gr-limesdr
    limesuite
    gnuradio
    soapysdr
    gqrx

    # Hacking tools
    aircrack-ng
    fusee-launcher
    ghidra-bin
    insomnia
    ncat
    pcsctools
    pwndbg
    python37Packages.binwalk-full
    python37Packages.shodan

    # Security
    (pass.withExtensions (exts: [ exts.pass-otp ]))
    _1password
    keybase-gui
    wireguard
    yubikey-manager
    yubioath-desktop

    # Syncing
    dropbox
    syncthing-cli
    syncthing-gtk

    # GUI tools
    evince
    gnome3.eog
    gnome3.gnome-system-monitor
    googleearth
    kitty
    libreoffice-fresh
    zathura

    # Web
    fullFirefox
    google-chrome
    tor-browser-bundle-bin

    # Communication
    discord
    signal-desktop
    slack
    tdesktop

    # Gnome configuration
    gnome3.adwaita-icon-theme
    gnome3.gnome-tweak-tool
    gnomeExtensions.appindicator
    hicolor-icon-theme
    numix-icon-theme
    numix-icon-theme-circle

    # Games
    multimc
  ]) ++ (with pkgs.hunspellDicts; [
    en-us-large
    de_DE
  ]);
}
