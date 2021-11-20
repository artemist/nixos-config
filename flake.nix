{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rustybar = {
      url = "github:mildlyfunctionalgays/rustybar";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    private.url = "git+ssh://git@github.com/artemist/nixos-config-private?ref=unified";

    wip-pinebook-pro = {
      url = "github:samueldr/wip-pinebook-pro";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, rustybar, private, wip-pinebook-pro }:
    let
      defaultModules = [
        ({ pkgs, ... }: {
          nixpkgs.overlays = [ rustybar.overlay ];
        })
        private.nixosModules.base
        home-manager.nixosModules.home-manager
      ];
      makeSystem = conf: nixpkgs.lib.nixosSystem (nixpkgs.lib.recursiveUpdate
        {
          specialArgs = {
            inherit rustybar;
          };
        }
        conf);
    in
    {
      nixosConfigurations.starlight = makeSystem {
        system = "x86_64-linux";
        modules = defaultModules ++ [
          ./system/starlight
          private.nixosModules.starlight
        ];
      };

      nixosConfigurations.rainbowdash = makeSystem {
        system = "x86_64-linux";
        modules = defaultModules ++ [
          ./system/rainbowdash
        ];
      };

      nixosConfigurations.spike = makeSystem {
        system = "x86_64-linux";
        modules = defaultModules ++ [
          ./system/spike
        ];
      };

      nixosConfigurations.mistmane = makeSystem {
        system = "aarch64-linux";
        modules = defaultModules ++ [
          ./system/mistmane
        ];
      };

    };
}

