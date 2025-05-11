{ lib, username, email, platform, ... }:
{
  imports = [
    ./bitwarden.nix
    ./neovim
    ./syncthing.nix
  ] ++ lib.optionals (platform == "nixos") [
    ./discord.nix
    ./sway.nix
    ./ui.nix
  ];

  home = {
    inherit username;
    stateVersion = "24.11";
  }; # // (lib.mkIf (platform != "darwin") { homeDirectory = "/home/${username}"; });

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
