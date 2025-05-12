{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./lsp.nix
    ./mini.nix
    ./telescope.nix
  ];

  options.pigeon.neovim.enable = lib.mkEnableOption "neovim";

  config = lib.mkIf config.pigeon.neovim.enable {
    programs = {
      nixvim = {
        enable = true;

        extraPackages = [
          pkgs.nixfmt-rfc-style
          pkgs.ripgrep
        ];

        defaultEditor = true;

        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;

        opts = {
          number = true;
          relativenumber = true;

          tabstop = 4;
          shiftwidth = 4;
          expandtab = true;

          list = true;
          listchars = "tab:>·,trail:·,extends:>,precedes:<,nbsp:+";
        };

        globals.mapleader = " ";

        files."ftplugin/nix.lua" = {
          opts = {
            shiftwidth = 2;
            tabstop = 2;
          };
        };

        autoGroups = {
          pigeon = {
            clear = true;
          };
        };

        autoCmd = [
          {
            event = [ "InsertEnter" ];
            command = "set norelativenumber";
            group = "pigeon";
          }
          {
            event = [ "InsertLeave" ];
            command = "set relativenumber";
            group = "pigeon";
          }
          {
            event = [ "TextYankPost" ];
            command = "silent! lua vim.highlight.on_yank({higroup='IncSearch', timeout=200})";
            group = "pigeon";
          }
        ];
      };
    };
  };
}
