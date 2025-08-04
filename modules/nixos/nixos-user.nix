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
      shell = lib.mkOption {
        description = "shell package";
        default = pkgs.fish;
      };
    };
  };

  config = lib.mkIf config.nixos-user.enable {
    users.users.${config.nixos-user.username} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "adbusers"
      ];
      shell = config.nixos-user.shell;
    };
    programs.fish.enable = true;
  };
}
