{ lib, config, ... }: {
  options = {
    macos-user = {
      enable = lib.mkEnableOption "enable the macos-user module";
      username = lib.mkOption { description = "username"; };
    };
  };

  config = lib.mkIf config.macos-user.enable {
    users.users.${config.macos-user.username} = {
      name = config.macos-user.username;
      home = "/Users/${config.macos-user.username}";
    };
  };
}
