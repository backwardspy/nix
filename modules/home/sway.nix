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

        input."*" = {
          repeat_rate = "80";
          repeat_delay = "250";
        };

        keybindings = lib.mkOptionDefault {
          "${modifier}+space" = "exec ${menu}";
          "Print" = "exec grimshot copy anything";
          "Mod1+Print" = "exec grimshot copy active";
          "${modifier}+m" = "mode mousekeys";
        };

        defaultWorkspace = "workspace number 1";

        seat."*".hide_cursor = "3000"; # hide mouse after 3 seconds of inactivity

        modes."mousekeys" = {
          "i" = "seat * cursor move 0 -10";
          "k" = "seat * cursor move 0 10";
          "j" = "seat * cursor move -10 0";
          "l" = "seat * cursor move 10 0";
          "a" = "seat * cursor press button1";
          "--release a" = "seat * cursor release button1";
          "s" = "seat * cursor press button2";
          "--release s" = "seat * cursor release button2";
          "d" = "seat * cursor press button3";
          "--release d" = "seat * cursor release button3";
          "Escape" = "mode default";
          "Return" = "mode default";
        };

        bars = [
          (
            {
              statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs $HOME/.config/i3status-rust/config-default.toml";
              command = "${pkgs.waybar}/bin/waybar";
            }
            // config.stylix.targets.sway.exportedBarConfig
          )
        ];
      };
      extraConfig = ''
        exec ${pkgs.autotiling-rs}/bin/autotiling-rs
        include /etc/sway/config.d/*
      '';
    };

    home.packages = with pkgs; [
      sway-contrib.grimshot
      wl-clipboard
    ];

    # tofi's drun cache is weirdly permanent
    home.activation = {
      clearTofiCache = lib.hm.dag.entryAfter [
        "writeBoundary"
      ] "[ -e $HOME/.cache/tofi-drun ] && rm $HOME/.cache/tofi-drun";
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
