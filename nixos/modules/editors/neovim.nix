{ config, lib, pkgs, ... }:

with lib;
with lib.my;

let
  cfg = config.modules.editors.neovim;
in {
  options.modules.editors.neovim = {
    enable = mkEnableOption' "neovim";
    defaultEditor = mkBooleanOption "make neovim to the default editor" true;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ 
      (let
        neovim-fhs = pkgs.buildFHSUserEnv {
          name = "nvim";
          targetPkgs = (inpkgs: (with inpkgs; [
            neovim

            # language toolkits
            (let 
              python-with-pkgs = python3.withPackages (ps: with ps; [
                pip
                pynvim
              ]);
            in
              python-with-pkgs)
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
          ]));
          runScript = "nvim";
        };
      in neovim-fhs)
    ];
  };
}
