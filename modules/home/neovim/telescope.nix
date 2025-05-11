{
  programs.nixvim = {
    keymaps = [
      {
        key = "<leader>f";
        action = "<cmd>Telescope find_files<cr>";
        options = { desc = "Find files"; };
      }
      {
        key = "<leader>b";
        action = "<cmd>Telescope buffers<cr>";
        options = { desc = "Buffers"; };
      }
      {
        key = "<leader>s";
        action = "<cmd>Telescope live_grep<cr>";
        options = { desc = "Search"; };
      }
    ];

    plugins.telescope.enable = true;

    plugins.mini = {
      enable = true;
      mockDevIcons = true;
      modules.icons = { };
    };
  };
}
