{
  platform,
  username,
  email,
  ...
}:
{
  home = {
    inherit username;
    stateVersion = "24.11";
  };

  pigeon = {
    bitwarden.enable = true;
    discord.enable = true;
    neovim.enable = true;
    spotify.enable = true;
    sway.enable = true;
    syncthing.enable = true;
  };

  # TODO: move into reusable modules
  programs = {
    direnv.enable = true;
    fish = {
      enable = true;
      functions = {
        fish_greeting = "";
      };
      shellAbbrs = {
        ga = "git add";
        gaa = "git add -A";
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
      userName = username;
      userEmail = email;
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
    chromium = {
      enable = platform != "darwin";
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
        { id = "nngceckbapebfimnlniiiahkandclblb"; }
        { id = "enamippconapkdmgfgjchkhakpfinmaj"; }
        { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; }
        { id = "gfbliohnnapiefjpjlpjnehglfpaknnc"; }
      ];
    };
  };

  services.blueman-applet.enable = platform == "nixos";
}
