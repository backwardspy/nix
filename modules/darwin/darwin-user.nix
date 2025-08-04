{
  lib,
  config,
  ...
}:
{
  options = {
    darwin-user = {
      enable = lib.mkEnableOption "enable the darwin-user module";
      username = lib.mkOption { description = "username"; };
    };
  };

  config = lib.mkIf config.darwin-user.enable {
    users.users.${config.darwin-user.username} = {
      name = config.darwin-user.username;
      home = "/Users/${config.darwin-user.username}";
    };
  };
}
