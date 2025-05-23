{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.pigeon.toolchain.enable = lib.mkEnableOption "toolchain";

  config = lib.mkIf config.pigeon.toolchain.enable {
    environment.systemPackages = with pkgs; [
      bat
      fd
      file
      htop
      jq
      ripgrep
      tealdeer
      yj
    ];
  };
}
