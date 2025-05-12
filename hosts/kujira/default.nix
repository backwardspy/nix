{
  pkgs,
  username,
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

  environment.systemPackages = with pkgs; [
    git
    neovim
  ];

  system.stateVersion = 6;
}
