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
      mkHomeConfig =
        {
          username,
          email,
          isGraphical,
        }:
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username} = ./modules/home;
            extraSpecialArgs = {
              inherit
                inputs
                username
                email
                isGraphical
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
          specialArgs = user;
          modules =
            [
              ./hosts/zephyr
              (mkHomeConfig (user // { isGraphical = true; }))
            ]
            ++ defaultModules
            ++ graphicalModules;
        };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    };
}
