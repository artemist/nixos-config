{ config, ... }:

{
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };
  home-manager.users.artemis = {
    imports = [
      ./git.nix
      ./mpv.nix
      ./kitty.nix
      ./neovim
      ./ssh
    ];

    home.stateVersion = config.system.stateVersion;

    services.syncthing.enable = true;
    programs.direnv = {
      enable = true;
      nix-direnv = { 
        enable = true;
        enableFlakes = true;
      };
    };

    xdg.enable = true;
    xdg.configFile = {
      "alacritty/alacritty.yml".source = ./files/alacritty.yml;
      "mimeapps.list".source = ./files/mimeapps.list;
      "swaylock/config".text = ''
        ignore-empty-password
        indicator-caps-lock
        show-failed-attempts
        image=${./files/xp.jpg}
      '';
    };
  };
}
