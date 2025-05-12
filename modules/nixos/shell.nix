{ config, lib, ... }:
{
  options.pigeon.shell.enable = lib.mkEnableOption "shell";

  config = lib.mkIf config.pigeon.shell.enable {
    programs.fish.enable = true;
  };
}
