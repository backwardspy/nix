{ config, lib, ... }:
{
  options.pigeon.bluetooth.enable = lib.mkEnableOption "bluetooth";

  config = lib.mkIf config.pigeon.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    services.blueman.enable = true;
  };
}
