{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.pigeon.ui.enable = lib.mkEnableOption "ui";

  config = lib.mkIf config.pigeon.ui.enable {
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    hardware.graphics.enable = true;

    fonts.packages = [ pkgs.nerd-fonts.symbols-only ];
  };
}
