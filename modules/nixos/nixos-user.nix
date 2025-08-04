{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    nixos-user = {
      enable = lib.mkEnableOption "enable nixos-user module";
      username = lib.mkOption { description = "username"; };
    };
  };

  config = lib.mkIf config.nixos-user.enable {
    users.users.${config.nixos-user.username} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "adbusers"
      ];
      shell = pkgs.fish;
    };
    programs.fish.enable = true;
  };
}
