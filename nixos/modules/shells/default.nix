{ config, lib, pkgs, ... }:

with lib;
with lib.my;

let
  cfg = config.modules.shells;
in {
  options.modules.shells = {
    prompts = {
      starship = {
        enable = mkEnableOption' "starship";
      };
    };
    direnv = {
      enable = mkEnableOption "direnv";
    };
  };

  config = {
    environment.systemPackages = (with pkgs;
      (optionals cfg.prompts.starship.enable [ starship ]) ++
      (optionals cfg.direnv.enable [
        direnv
        (nix-direnv.override {
          enableFlakes = true;
        })])
    );

    programs.bash.promptInit = optionalString cfg.prompts.starship.enable ''
      eval "$(starship init bash)"
    '';
    environment.pathsToLink = optionals cfg.prompts.starship.enable [
      "/share/nix-direnv"
    ];
  };
}
