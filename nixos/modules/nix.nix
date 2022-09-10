{ config, lib, ... }:

with lib;
with lib.my;

let
  cfg = config.modules.nix;
in {
  options.modules.nix = {
    systemFlake = {
      register = mkBooleanOption "whether to register the system flake located at config.modules.nix.systemFlake.path to the global flake registry" true;
      path = mkOption {
        default = ../.;
        example = ./.;
        description = "the path to the directory in which the system flake is saved";
        type = types.path;
      };
    };
  };

  config.nix = {
    registry = mkIf cfg.systemFlake.register {
      system = {
        from = {
          type = "indirect";
          id = "system";
        };
        to = {
          type = "path";
          path = "${cfg.systemFlake.path}";
        };
      };
    };
  };
}
