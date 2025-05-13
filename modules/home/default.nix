{ ... }:
{
  imports = [
    ./bitwarden.nix
    ./discord.nix
    ./neovim
    ./spotify.nix
    ./sway.nix
    ./syncthing.nix
    ./ui.nix
  ];

  programs.home-manager.enable = true;
}
