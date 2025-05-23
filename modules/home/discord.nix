{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.pigeon.discord.enable = lib.mkEnableOption "discord";

  config = lib.mkIf config.pigeon.discord.enable {
    home.packages = [ pkgs.discord ];
  };
}
