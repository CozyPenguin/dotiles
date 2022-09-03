{ lib, ... }:
with lib;
{
  options.lango.settings = {
    desktop = mkOption {
      default = "gnome";
      type = types.str;
    };
  };
}
