{ config, lib, pkgs, ... }:

with lib;
with lib.my;

let
  cfg = config.modules.editors.neovim;
in {
  options.modules.editors.neovim = {
    enable = mkEnableOption' "neovim";
    defaultEditor = mkBooleanOption "make neovim the default editor" true;
    languages = {
      python = mkEnableOption' "python";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ 
    
      (let
        neovim-fhs = pkgs.buildFHSUserEnv {
          name = "nvim";
          targetPkgs = (inpkgs: (with inpkgs; [
            neovim-unwrapped

            # copy & paste
            wl-clipboard

            # language toolkits
            go
            cargo
            rustc
            gcc
            adoptopenjdk-bin
            ruby
            perl
            nodejs
            nodePackages.npm
            nodePackages.neovim
            php
            luarocks

            git
            bash

            # mason
            curl
            wget
            unzip
          ] ++ optionals cfg.languages.python [
            (python3.withPackages (ps: with ps; [
              pip
              pynvim
            ]))
          ]));
          runScript = "nvim";
        };
      in neovim-fhs)
    ];
    
    environment.sessionVariables.EDITOR = mkIf cfg.defaultEditor "nvim";
  };
}
