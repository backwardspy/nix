{ pkgs, ... }:
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/irblack.yaml";
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
}
