{ ... }:

{
  imports = [ ../externals/home-manager/nixos ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };
  home-manager.users.artemis = { pkgs, ... }: {
    imports = [
      ./git.nix
    ];

    xdg.enable = true;
    xdg.configFile = {
      "alacritty/alacritty.yml".source = ./alacritty.yml;
      "mpv/mpv.conf".source = ./mpv.conf;
      "swaylock/config".text = ''
        daemonize
        ignore-empty-password
        indicator-caps-lock
        show-failed-attempts
        show-keyboard-layout
        image=${./xp.jpg}
      '';
    };
  };
}
