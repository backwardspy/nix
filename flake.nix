{
  description = "pigeon's system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
      hmConfig =
        { username }:
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username} = ./modules/home;
            extraSpecialArgs = { inherit inputs username; };
          };
        };
    in
    {
      nixosConfigurations."zephyr" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          username = "backwardspy";
        };
        modules =
          [
            ./hosts/zephyr
            (hmConfig { username = "backwardspy"; })
          ]
          ++ defaultModules
          ++ graphicalModules;
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    };
}
