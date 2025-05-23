{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.pigeon.sway.enable = lib.mkEnableOption "sway";

  config = lib.mkIf config.pigeon.sway.enable {
    pigeon.ui.enable = true;

    wayland.windowManager.sway = {
      enable = true;
      config = rec {
        modifier = "Mod4";
        menu = "${pkgs.tofi}/bin/tofi-drun --font '${pkgs.unifont}/share/fonts/opentype/unifont.otf' --drun-launch=true";
        keybindings = lib.mkOptionDefault {
          "${modifier}+space" = "exec ${menu}";
        };
        defaultWorkspace = "workspace number 1";

        seat."*".hide_cursor = "3000"; # hide mouse after 3 seconds of inactivity

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
      extraConfig = ''
        exec ${pkgs.autotiling-rs}/bin/autotiling-rs
        include /etc/sway/config.d/*
      '';
    };

    home.packages = with pkgs; [
      grim
      slurp
      wl-clipboard
    ];

    # tofi's drun cache is weirdly permanent
    home.activation = {
      clearTofiCache = lib.hm.dag.entryAfter [ "writeBoundary" ] "[ -e $HOME/.cache/tofi-drun ] && rm $HOME/.cache/tofi-drun";
    };

    services = {
      mako = {
        enable = true;
        settings.default-timeout = 10000;
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
        # TODO: shouldn't stylix handle this?
        settings.main.font = "VGA:size=12";
      };
    };
  };
}
