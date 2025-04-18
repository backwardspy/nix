{
  programs.nixvim.plugins.mini = {
    enable = true;
    modules = {
      clue = {
        window.delay = 0;

        triggers = [
          {
            mode = "n";
            keys = "<Leader>";
          }
          {
            mode = "x";
            keys = "<Leader>";
          }

          {
            mode = "i";
            keys = "<C-x>";
          }

          {
            mode = "n";
            keys = "g";
          }
          {
            mode = "x";
            keys = "g";
          }

          {
            mode = "n";
            keys = "'";
          }
          {
            mode = "n";
            keys = "`";
          }
          {
            mode = "x";
            keys = "'";
          }
          {
            mode = "x";
            keys = "`";
          }

          {
            mode = "n";
            keys = "\"";
          }
          {
            mode = "x";
            keys = "\"";
          }
          {
            mode = "i";
            keys = "<C-r>";
          }
          {
            mode = "c";
            keys = "<C-r>";
          }

          {
            mode = "n";
            keys = "<C-w>";
          }

          {
            mode = "n";
            keys = "z";
          }
          {
            mode = "x";
            keys = "z";
          }
        ];

        clues = {
          "__unkeyed-1" = {
            __raw = "require('mini.clue').gen_clues.builtin_completion()";
          };
          "__unkeyed-2" = {
            __raw = "require('mini.clue').gen_clues.g()";
          };
          "__unkeyed-3" = {
            __raw = "require('mini.clue').gen_clues.marks()";
          };
          "__unkeyed-4" = {
            __raw = "require('mini.clue').gen_clues.registers()";
          };
          "__unkeyed-5" = {
            __raw = "require('mini.clue').gen_clues.windows()";
          };
          "__unkeyed-6" = {
            __raw = "require('mini.clue').gen_clues.z()";
          };
        };
      };
    };
  };
}
