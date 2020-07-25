{ config, pkgs, ... }:

let
  llvm = pkgs.llvmPackages_10;
  unwrappedFirefox = pkgs.firefox-bin-unwrapped.override { systemLocale = "de-DE"; };
  fullFirefox = (pkgs.wrapFirefox unwrappedFirefox {
    browserName = "firefox";
    desktopName = "Firefox";
    forceWayland = true;
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

    # Books
    calibre

    # Emulation
    mgba
    mupen64plus

    # Wine and tools
    cabextract
    samba
    wineWowPackages.staging

    # Virtualization
    docker-compose
    gnome3.gnome-boxes
    qemu

    # Linux tools
    cachix
    dmidecode
    efibootmgr
    efitools
    gparted
    hdparm
    i7z
    iptables
    krb5
    libva-utils
    linuxPackages.cpupower
    lm_sensors
    manpages
    nethogs
    nvme-cli
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
    glib
    grim
    imagemagick
    libnotify
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
    pandoc
    parallel
    pciutils
    pdftk
    pijul
    poppler_utils
    ripgrep
    rlwrap
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
    ytop
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
    arduino
    bear
    binutils-unwrapped
    ccache
    clang-tools
    cmake
    conda
    gcc9
    gdb
    gnumake
    llvm.clang
    llvm.lld
    nasm
    nixpkgs-fmt
    nodejs
    patchelf
    python3Packages.python-language-server
    rnix-lsp
    rustup
    valgrind
    vscode
    yarn

    # Radio
    gr-limesdr
    limesuite
    gnuradio-with-packages
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
    python3Packages.binwalk-full
    python3Packages.shodan

    # Security
    (pass.withExtensions (exts: [ exts.pass-otp ]))
    _1password
    keybase-gui
    opensc
    wireguard
    yubikey-manager
    yubioath-desktop

    # Syncing
    dropbox
    syncthing-cli
    syncthing-gtk

    # GUI tools
    alacritty
    evince
    gnome3.eog
    gnome3.gnome-system-monitor
    libreoffice-fresh
    zathura

    # Web
    chromium
    fullFirefox
    tor-browser-bundle-bin

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
  ]) ++ (with pkgs.hunspellDicts; [
    en-us-large
    de_DE
  ]);
}
