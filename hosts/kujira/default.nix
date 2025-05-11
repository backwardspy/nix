{
  pkgs,
  username,
  ...
}:
{
  imports = [ ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.hostPlatform = "x86_64-darwin";

  networking.hostName = "kujira";

  time.timeZone = "Europe/London";

  environment.systemPackages = with pkgs; [
    git
    neovim
  ];

  system.stateVersion = 6;
}
