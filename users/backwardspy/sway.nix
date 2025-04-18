{ pkgs, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      menu = "tofi-drun --font ${pkgs.noto-fonts}/share/fonts/noto/NotoSans[wdth,wght].ttf";
    };
    extraConfig = "include /etc/sway/config.d/*";
  };

  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    mako
    tofi
  ];
}
