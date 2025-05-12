{
  config,
  lib,
  hostname,
  ...
}:
let
  # devices with nix-managed syncthing need to add other nix devices but not themselves
  devices = [
    {
      name = "hyperion";
      id = "5RVRAO2-TK4ITIR-W6O3W4Y-PHW5FPZ-PGOA7LR-M36WLMJ-JHWYMNU-JQYI2QI";
    }
    {
      name = "galactica";
      id = "WO27XPZ-TZ5O5MX-A3FQWOO-FAZG6OV-R7ZHLAM-3J3APEZ-EWAND3O-U267MAW";
    }
    {
      name = "zephyr";
      id = "LHY5B44-CMYADIP-FKENFCK-TCBLRGX-5AXV6D3-4AMYVIG-GYUFRAQ-K7NRTQV";
    }
    {
      name = "kujira";
      id = "RULL2TJ-MJKMACY-ZKW5MPC-3X345JR-3YZ6OVI-SP62GWQ-J3V3F42-BQYRXAZ";
    }
  ];
  otherDevices = (lib.filter (device: device.name != hostname) devices);
  otherDeviceNames = map (device: device.name) otherDevices;
in
{
  options.pigeon.syncthing.enable = lib.mkEnableOption "syncthing";

  config = lib.mkIf config.pigeon.syncthing.enable {
    services.syncthing = {
      enable = true;
      settings = {
        devices = lib.mapAttrs (name: value: { id = value; }) (
          lib.listToAttrs (map ({ name, id }: lib.nameValuePair name id) otherDevices)
        );
        folders = {
          "~/notes" = {
            id = "notes";
            devices = otherDeviceNames;
          };
          "~/sync" = {
            id = "sync";
            devices = otherDeviceNames;
          };
        };
      };
    };
  };
}
