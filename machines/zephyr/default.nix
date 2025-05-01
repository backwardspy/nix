{
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./bluetooth.nix
    ./stylix.nix
    ./sway.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "zephyr";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  users.users.backwardspy = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
  ];

  services.openssh.enable = true;

  system.stateVersion = "24.11";
}
