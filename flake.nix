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
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
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
      nix-homebrew,
      homebrew-cask,
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
          }
          // user;
          modules = [
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

      darwinConfigurations."kujira" =
        let
          user = {
            username = "backwardspy";
            email = "backwardspy@pigeon.life";
          };
        in
        nix-darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          specialArgs = {
            inherit inputs;
          }
          // user;
          modules = [
            ./hosts/kujira
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            (mkHomeConfig (
              user
              // {
                hostname = "kujira";
                platform = "darwin";
              }
            ))
          ];
        };

      homeModules.default = ./modules/home;

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    };
}
