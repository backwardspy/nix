{
  lib,
  platform,
  ...
}:
{
  imports =
    [
      ./bitwarden.nix
      ./neovim
      ./syncthing.nix
    ]
    ++ lib.optionals (platform == "nixos") [
      ./discord.nix
      ./sway.nix
      ./ui.nix
    ];

  programs.home-manager.enable = true;

}
