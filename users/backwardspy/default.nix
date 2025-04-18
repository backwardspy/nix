{ inputs, ... }:
{
  imports = [
    ./neovim
    ./sway.nix
  ];

  home = {
    username = "backwardspy";
    homeDirectory = "/home/backwardspy";
    stateVersion = "24.11";
  };

  programs = {
    direnv.enable = true;
    fish.enable = true;
    git = {
      enable = true;
      lfs.enable = true;
      userName = "backwardspy";
      userEmail = "backwardspy@pigeon.life";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
    home-manager.enable = true;
    chromium = {
      enable = true;
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
        { id = "nngceckbapebfimnlniiiahkandclblb"; }
        { id = "enamippconapkdmgfgjchkhakpfinmaj"; }
        { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; }
      ];
    };
  };
}
