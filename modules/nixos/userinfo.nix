{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    userinfo = {
      enable = lib.mkEnableOption "enable userinfo module";
      username = lib.mkOption {
        description = "username";
      };
    };
  };

  config = lib.mkIf config.userinfo.enable {
    users.users.${config.userinfo.username} = {
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
