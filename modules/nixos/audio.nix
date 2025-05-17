{ config, lib, ... }:
{
  options.pigeon.audio.enable = lib.mkEnableOption "audio";

  config = lib.mkIf config.pigeon.audio.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
