{ ... }:

{
  imports = [
    ../externals/home-manager/nixos
  ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };
  home-manager.users.artemis = {
    imports = [
      ./git.nix
      ./mpv.nix
      ./neovim
    ];

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
