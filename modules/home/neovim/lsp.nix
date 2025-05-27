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
        basedpyright.enable = true;
        ruff.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        taplo.enable = true;
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
    {
      action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
      key = "<leader>a";
      options = {
        desc = "Code Actions";
      };
    }
    {
      action = "<cmd>lua vim.lsp.buf.hover()<cr>";
      key = "<leader>h";
      options = {
        desc = "Hover";
      };
    }
    {
      action = "<cmd>lua vim.lsp.buf.signature_help()<cr>";
      key = "<C-s>";
      options = {
        desc = "Signature Help";
      };
    }
  ];
}
