{ ... }:

{
  imports = [
    ../externals/home-manager/nixos
  ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };
  home-manager.users.artemis = { pkgs, ... }: {
    imports = [
      ./git.nix
      ./neovim
    ];

    xdg.enable = true;
    xdg.configFile = {
      "alacritty/alacritty.yml".source = ./files/alacritty.yml;
      "mpv/mpv.conf".source = ./files/mpv/mpv.conf;
      "mpv/input.conf".source = ./files/mpv/input.conf;
      "mimeapps.list".source = ./files/mimeapps.list;
      "swaylock/config".text = ''
        daemonize
        ignore-empty-password
        indicator-caps-lock
        show-failed-attempts
        show-keyboard-layout
        image=${./files/xp.jpg}
      '';
    };
  };
}
