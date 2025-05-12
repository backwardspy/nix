{ config, lib, ... }:
{
  options.pigeon.discord.enable = lib.mkEnableOption "discord";

  config = lib.mkIf config.pigeon.discord.enable {
    programs.vesktop.enable = true;
    stylix.targets.vesktop.enable = false;
  };
}
