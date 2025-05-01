{
  pkgs,
  lib,
  config,
  ...
}:
{
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      menu = "${pkgs.tofi}/bin/tofi-drun --font '${pkgs.unifont}/share/fonts/opentype/unifont.otf' --drun-launch=true";
      keybindings = lib.mkOptionDefault {
        "${modifier}+space" = "exec ${menu}";
      };
      defaultWorkspace = "workspace number 1";

      bars = [
        (
          {
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs $HOME/.config/i3status-rust/config-default.toml";
            command = "${pkgs.waybar}/bin/waybar";
          }
          // config.lib.stylix.sway.bar
        )
      ];
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

  programs.foot = {
    enable = true;
    # TODO: shouldn't stylix handle these?
    settings = {
      main.font = "VGA:size=12";
    };
  };

  programs.i3status-rust.enable = true;

  programs.waybar.enable = true;

  gtk.iconTheme = {
    package = pkgs.hicolor-icon-theme;
    name = "hicolor";
  };
}
