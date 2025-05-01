{ pkgs, ... }:
{
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
}
