{
  pkgs,
  username,
  ...
}:
{
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "zephyr";
  networking.networkmanager.enable = true;

  i18n.defaultLocale = "en_GB.UTF-8";
  time.timeZone = "Europe/London";

  nixos-user = {
    enable = true;
    inherit username;
  };
  home-manager.users.${username} = ./home.nix;

  pigeon = {
    audio.enable = true;
    bluetooth.enable = true;
    shell.enable = true;
    stylix.enable = true;
    sway.enable = true;
    toolchain.enable = true;
  };

  environment.systemPackages = with pkgs; [
    neovim
  ];

  # allows adb/fastboot access for the `adbusers` group
  services.udev.extraRules = ''
    # ID 12d1:1c2c Huawei Technologies Co., Ltd. HUAWEI WATCH
    SUBSYSTEM=="usb", ATTR{idVendor}=="12d1", ATTR{idProduct}=="1c2c", MODE="0666", GROUP="adbusers", TAG+="uaccess"

    # ID 18d1:d001 Google Inc. Nexus 4 (fastboot)
    # NOTE: asteroidos in adb mode
    SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="d001", MODE="0666", GROUP="adbusers", TAG+="uaccess"

    # ID 18d1:d00d Google Inc. Xiaomi Mi/Redmi 2 (fastboot)
    # NOTE: this is actually from the huawei watch but i think fastboot always exposes as this xiaomi/redmi device.
    SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="d00d", MODE="0666", GROUP="adbusers", TAG+="uaccess"
  '';

  system.stateVersion = "24.11";
}
