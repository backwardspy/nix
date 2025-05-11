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
  ];

  services = {
    mako = {
      enable = true;
      defaultTimeout = 10000;
    };

    swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 180;
          command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
          resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
        }
      ];
    };
  };

  programs = {
    waybar.enable = true;
    i3status-rust.enable = true;
    tofi.enable = true;
    foot = {
      enable = true;
      # TODO: shouldn't stylix handle these?
      settings = {
        main.font = "VGA:size=12";
      };
    };
  };
}
