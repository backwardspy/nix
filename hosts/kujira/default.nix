{
  lib,
  pkgs,
  config,
  username,
  inputs,
  ...
}:
{
  imports = [ ../../modules/darwin/darwin-user.nix ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.hostPlatform = "x86_64-darwin";

  networking.hostName = "kujira";

  time.timeZone = "Europe/London";

  darwin-user = {
    enable = true;
    username = "backwardspy";
  };
  home-manager.users.${username} = ./home.nix;

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
    ];

  environment.systemPackages = with pkgs; [
    git
    neovim
  ];

  environment.shells = [ pkgs.fish ];

  programs.fish.enable = true;

  nix-homebrew = {
    enable = true;
    user = username;

    taps = {
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };

    mutableTaps = false;
  };

  homebrew = {
    taps = builtins.attrNames config.nix-homebrew.taps;
    casks = [ "ghostty" ];
  };

  system.stateVersion = 6;
}
