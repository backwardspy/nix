{ pkgs, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      menu = "${pkgs.tofi}/bin/tofi-drun --font '${pkgs.noto-fonts}/share/fonts/noto/NotoSans[wdth,wght].ttf' --drun-launch=true";
    };
    extraConfig = "include /etc/sway/config.d/*";
  };

  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    mako
  ];

  programs.tofi.enable = true;
}
