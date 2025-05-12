{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.pigeon.sway.enable = lib.mkEnableOption "sway";

  config = lib.mkIf config.pigeon.sway.enable {
    pigeon.ui.enable = true;

    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };
}
