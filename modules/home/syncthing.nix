{ lib, hostname, ... }:
let
  # devices with nix-managed syncthing need to add other nix devices but not themselves
  nixDevice = { name, id }: lib.optionalAttrs (hostname != name) { "${name}" = { inherit id; }; };
in
{
  services.syncthing = {
    enable = true;
    settings = {
      devices =
        {
          "hyperion".id = "5RVRAO2-TK4ITIR-W6O3W4Y-PHW5FPZ-PGOA7LR-M36WLMJ-JHWYMNU-JQYI2QI";
          "galactica".id = "WO27XPZ-TZ5O5MX-A3FQWOO-FAZG6OV-R7ZHLAM-3J3APEZ-EWAND3O-U267MAW";
        }
        // (nixDevice {
          name = "zephyr";
          id = "LHY5B44-CMYADIP-FKENFCK-TCBLRGX-5AXV6D3-4AMYVIG-GYUFRAQ-K7NRTQV";
        })
        // (nixDevice {
          name = "kujira";
          id = "RULL2TJ-MJKMACY-ZKW5MPC-3X345JR-3YZ6OVI-SP62GWQ-J3V3F42-BQYRXAZ";
        });
      folders = {
        "~/camera" = {
          id = "pixel_7_pro_3prk-photos";
          devices = [
            "hyperion"
            "galactica"
          ];
        };
        "~/notes" = {
          id = "notes";
          devices = [
            "hyperion"
            "galactica"
          ];
        };
        "~/sync" = {
          id = "sync";
          devices = [
            "hyperion"
            "galactica"
          ];
        };
      };
    };
  };
}
