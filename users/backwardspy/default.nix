{ inputs, ... }:
{
  imports = [
    ./discord.nix
    ./neovim
    ./sway.nix
    ./ui.nix
  ];

  home = {
    username = "backwardspy";
    homeDirectory = "/home/backwardspy";
    stateVersion = "24.11";
  };

  programs = {
    home-manager.enable = true;
    direnv.enable = true;
    fish = {
      enable = true;
      functions = {
        fish_greeting = "";
      };
      shellAbbrs = {
        ga = "git add";
        gb = "git branch";
        gc = "git commit";
        gco = "git checkout";
        gd = "git diff";
        gl = "git pull";
        gp = "git push";
        gr = "git rebase";
        gra = "git rebase --abort";
        grc = "git rebase --continue";
        gs = "git switch";
        gsm = "git switch main";
        gst = "git status";
        la = "eza -a";
        ll = "eza -l";
        lla = "eza -la";
        ls = "eza";
      };
      preferAbbrs = true;
    };
    eza = {
      enable = true;
      git = true;
      icons = "auto";
    };
    git = {
      enable = true;
      lfs.enable = true;
      userName = "backwardspy";
      userEmail = "backwardspy@pigeon.life";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
    chromium = {
      enable = true;
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
        { id = "nngceckbapebfimnlniiiahkandclblb"; }
        { id = "enamippconapkdmgfgjchkhakpfinmaj"; }
        { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; }
        { id = "gfbliohnnapiefjpjlpjnehglfpaknnc"; }
      ];
    };
  };

  services.blueman-applet.enable = true;
}
