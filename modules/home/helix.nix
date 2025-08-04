{ lib, config, ... }:
{
  options.pigeon.helix.enable = lib.mkEnableOption "helix";

  config = lib.mkIf config.pigeon.helix.enable {
    programs.helix = {
      enable = true;
      settings = {
        editor = {
          line-number = "relative";
          cursorline = true;
          color-modes = true;
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          indent-guides = {
            render = true;
          };
        };
      };
    };

    xdg.configFile."helix/themes/catppuccin_latte.toml".text = builtins.readFile (
      builtins.fetchurl {
        url = "https://github.com/catppuccin/helix/raw/refs/heads/main/themes/default/catppuccin_latte.toml";
        sha256 = "0lsqm8axn09lp8p5c06prywbv3j2irkwygp97m4ly65nbxmbfmiz";
      }
    );
    xdg.configFile."helix/themes/catppuccin_mocha.toml".text = builtins.readFile (
      builtins.fetchurl {
        url = "https://github.com/catppuccin/helix/raw/refs/heads/main/themes/default/catppuccin_mocha.toml";
        sha256 = "0slfn1rrim2ad0101axk2dw1qyls01n0n9jj8h0ddhrpaqlx3fjq";
      }
    );
  };
}
