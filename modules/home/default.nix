{ ... }:
{
  imports = [
    ./bitwarden.nix
    ./discord.nix
    ./helix.nix
    ./neovim
    ./spotify.nix
    ./sway.nix
    ./syncthing.nix
    ./ui.nix
  ];

  programs.home-manager.enable = true;
}
