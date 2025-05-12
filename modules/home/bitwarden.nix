{
  config,
  lib,
  pkgs,
  email,
  ...
}:
{
  options.pigeon.bitwarden.enable = lib.mkEnableOption "bitwarden";

  config = lib.mkIf config.pigeon.bitwarden.enable {
    programs.rbw = {
      enable = true;
      settings = {
        inherit email;
        pinentry = pkgs.pinentry-tty;
      };
    };
  };
}
