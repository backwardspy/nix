{
  description = "pigeon's system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:/nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      nix-index-database,
      nixvim,
      stylix,
    }@inputs:
    let
      defaultModules = [
        home-manager.nixosModules.home-manager
        nix-index-database.nixosModules.nix-index
      ];
      graphicalModules = [
        stylix.nixosModules.stylix
      ];
      mkHomeConfig =
        {
          hostname,
          username,
          email,
          platform,
        }:
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            sharedModules = [ inputs.self.outputs.homeModules.default ];
            extraSpecialArgs = {
              inherit
                inputs
                hostname
                username
                email
                platform
                ;
            };
          };
        };
    in
    {
      nixosConfigurations."zephyr" =
        let
          user = {
            username = "backwardspy";
            email = "backwardspy@pigeon.life";
          };
        in
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          } // user;
          modules =
            [
              ./hosts/zephyr
              (mkHomeConfig (
                user
                // {
                  hostname = "zephyr";
                  platform = "nixos";
                }
              ))
            ]
            ++ defaultModules
            ++ graphicalModules;
        };

      darwinConfigurations."kujira" = nix-darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./hosts/kujira
          home-manager.darwinModules.home-manager
          (mkHomeConfig ({
            username = "backwardspy";
            email = "backwardspy@pigeon.life";
            hostname = "kujira";
            platform = "darwin";
          }))
        ];
      };

      homeModules.default = ./modules/home;

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    };
}
