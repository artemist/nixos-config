{ config, pkgs, ... }:

let
  llvm = pkgs.llvmPackages_10;
  go = pkgs.go_1_15;
  wofi = pkgs.wofi.overrideAttrs ( old: {
    src = pkgs.fetchhg {
      url = old.src.url;
      rev = "e3db9b8075e71399bba14a568c59032f47981dab";
      sha256 = "07fr1yfls94gxpwv3azgzxm7shjs4g5ribvqrh88flpf4cv5hq2d";
    };
  } );
  openocd = if pkgs.stdenv.cc.isGNU then (pkgs.openocd.overrideAttrs ( old: {
    NIX_CFLAGS_COMPILE = old.NIX_CFLAGS_COMPILE ++ [ "-Wno-error=strict-prototypes" ];
  })) else pkgs.openocd;
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
    krb5
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
    nixpkgs-fmt
    nodejs
    patchelf
    python37Packages.python-language-server
    rnix-lsp
    rustup
    valgrind
    yarn

    # Embedded
    kicad-unstable
    openocd
    stlink
    (callPackage ./externals/packages/jlink { })

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
    python37Packages.binwalk-full
    python37Packages.shodan

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
