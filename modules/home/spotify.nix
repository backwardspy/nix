{
  hostname,
  email,
  config,
  lib,
  ...
}:
{
  options.pigeon.spotify.enable = lib.mkEnableOption "spotify";

  config = lib.mkIf config.pigeon.spotify.enable {
    programs.spotify-player = {
      enable = true;
      settings = {
        client_id = "6be7ecf27aa84c459d43c19c9db599c0";
        name = "zephyr";
      };
    };
  };
}
