# credits to hlissner/dotfiles
{ inputs, lib, pkgs, ... }:

let
  inherit (builtins) filter;
  inherit (lib) makeExtensible attrValues foldr;
  inherit (modules) mapModulesRec listModulesRec;

  modules = import ./modules.nix {
    inherit lib;
  };

  mylib = makeExtensible (self: { });
in
  mylib.extend
    (self: super:
      foldr
        (a: b: a // b)
        {}
        (filter (a: a != null) 
            (listModulesRec ./.
              (file: import file { inherit self lib pkgs inputs; }))))
