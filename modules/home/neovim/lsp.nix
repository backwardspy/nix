{
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        lua_ls.enable = true;
        nil_ls = {
          enable = true;
          settings.formatting.command = [ "nixfmt" ];
        };
        pyright.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
      };
    };

    lsp-format.enable = true;
  };

  programs.nixvim.keymaps = [
    {
      action = "<cmd>lua vim.diagnostic.open_float()<cr>";
      key = "<leader>e";
      options = {
        desc = "Show Diagnostic";
      };
    }
  ];
}
