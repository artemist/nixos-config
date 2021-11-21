{ inputs, ... }:

{
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };
  home-manager.users.artemis = {
    extraSpecialArgs.inputs = inputs;
    imports = [
      ./git.nix
      ./mpv.nix
      ./kitty.nix
      ./neovim
      ./ssh
    ];

    services.syncthing.enable = true;

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
