{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.pigeon.ui.enable = lib.mkEnableOption "ui";

  config = lib.mkIf config.pigeon.ui.enable {
    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.hackneyed;
      name = "Hackneyed (scalable)";
      size = 12;
    };

    gtk.iconTheme = {
      package = pkgs.hicolor-icon-theme;
      name = "hicolor";
    };
  };
}
