{ config, pkgs, ... }:

let
  llvm = pkgs.llvmPackages_10;
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
    ffmpeg-full
    flac
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
    mosh
    sshfs
    sshuttle
    transmission-gtk
    transmission-remote-gtk
    wget

    # Development
    bear
    binutils-unwrapped
    gdb
    nasm
    nixpkgs-fmt
    nodejs
    patchelf
    python3Packages.python-language-server
    rnix-lsp
    rustup
    yarn

    # Hacking tools
    aircrack-ng
    ncat
    pcsctools
    pwndbg
    python3Packages.binwalk-full

    # Security
    (pass.withExtensions (exts: [ exts.pass-otp ]))
    _1password
    opensc
    wireguard
    yubikey-manager
    yubioath-desktop

    # Syncing
    syncthing-cli
    syncthing-gtk

    # GUI tools
    alacritty
    evince
    gnome3.eog
    gnome3.gnome-system-monitor
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
