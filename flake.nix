{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/staging-next";

    home-manager = {
      url = "github:nix-community/home-manager/release-21.11";
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

  outputs = { self, nixpkgs, home-manager, rustybar, private, wip-pinebook-pro, nixpkgs-unstable, ... } @ inputs:
    let
      makeSystem = conf: nixpkgs.lib.nixosSystem (nixpkgs.lib.recursiveUpdate conf
        rec {
          specialArgs = {
            inherit inputs;
            pkgs-unstable = nixpkgs-unstable.legacyPackages."${conf.system}";
          };
          modules = [
            private.nixosModules.base
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = specialArgs;
            }
          ] ++ (conf.modules or [ ]);
        });
    in
    {
      nixosConfigurations.starlight = makeSystem {
        system = "x86_64-linux";
        modules = [
          ./system/starlight
          private.nixosModules.starlight
        ];
      };

      nixosConfigurations.rainbowdash = makeSystem {
        system = "x86_64-linux";
        modules = [
          ./system/rainbowdash
        ];
      };

      nixosConfigurations.spike = makeSystem {
        system = "x86_64-linux";
        modules = [
          ./system/spike
        ];
      };

      nixosConfigurations.mistmane = makeSystem {
        system = "aarch64-linux";
        modules = [
          ./system/mistmane
        ];
      };

    };
}

