{ config, ... }:

{
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };
  home-manager.users.artemis = {
    imports = [
      ./fish.nix
      ./gtk.nix
      ./git.nix
      ./mpv.nix
      ./kitty.nix
      ./ssh
      ./gpg.nix
      ./dirs.nix
    ];

    home.stateVersion = config.system.stateVersion;

    services.syncthing.enable = true;
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    xdg.enable = true;
    xdg.configFile = {
      "alacritty/alacritty.yml".source = ./files/alacritty.yml;
      "swaylock/config".text = ''
        ignore-empty-password
        indicator-caps-lock
        show-failed-attempts
        image=${./files/xp.jpg}
      '';
    };
  };
}
