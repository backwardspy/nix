{ pkgs, ... }:
{
  security.polkit.enable = true;

  services.gnome.gnome-keyring.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  hardware.graphics.enable = true;

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

  fonts.packages = [ pkgs.nerd-fonts.symbols-only ];
}
