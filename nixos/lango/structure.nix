{ lib, ... }:
with lib;
{
  options.lango.structure = {
    modulesPath = mkOption {
      default = "./modules";
      type = types.str;
      readOnly = true;
    };
  };
}
