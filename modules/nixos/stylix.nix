{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.pigeon.stylix.enable = lib.mkEnableOption "stylix";

  config = lib.mkIf config.pigeon.stylix.enable {
    stylix = {
      enable = true;
      polarity = "dark";
      base16Scheme = "${pkgs.base16-schemes}/share/themes/irblack.yaml";
      image = ../../assets/alonetogether.png;
      fonts = rec {
        monospace = {
          package = pkgs.uni-vga;
          name = "VGA";
        };
        serif = monospace;
        sansSerif = monospace;
        emoji = monospace;
        sizes = rec {
          applications = 12;
          desktop = applications;
          popups = applications;
          terminal = applications;
        };
      };
    };
  };
}
