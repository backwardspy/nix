{ pkgs, email, ... }:
{
  programs.rbw = {
    enable = true;
    settings = {
      inherit email;
      pinentry = pkgs.pinentry-tty;
    };
  };
}
