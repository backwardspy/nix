{ ... }:
{
  services.syncthing = {
    enable = true;
    settings = {
      devices = {
        "hyperion".id = "5RVRAO2-TK4ITIR-W6O3W4Y-PHW5FPZ-PGOA7LR-M36WLMJ-JHWYMNU-JQYI2QI";
        "galactica".id = "WO27XPZ-TZ5O5MX-A3FQWOO-FAZG6OV-R7ZHLAM-3J3APEZ-EWAND3O-U267MAW";
      };
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
