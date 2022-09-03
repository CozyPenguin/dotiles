# credits to hlissner/dotfiles
{ lib, ... }:

let
  inherit (builtins) readDir pathExists concatLists;
  inherit (lib) id nameValuePair mapAttrs' hasSuffix removeSuffix mapAttrsToList filterAttrs optionals;
in rec {  
  # mapModulesRec :: Path -> AttrSet
  mapModulesRec = (dir: fn: 
    mapAttrs'
      (name: value:
        let path = "${toString dir}/${name}"; in
        if value == "directory" then
          nameValuePair name (mapModulesRec path fn)
        else if value == "regular" && name != "default.nix" && hasSuffix ".nix" name then
          nameValuePair (removeSuffix ".nix" name) (fn path)
        else 
          nameValuePair "" null)
      (readDir dir));

  # listModulesRec :: Path -> (Path -> Any) -> [Any]
  listModulesRec = dir: fn:
    concatLists (mapAttrsToList
      (name: value:
        let path = "${toString dir}/${name}"; in
        if value == "directory" then
          (optionals (pathExists "${path}/default.nix") [ fn path ]) ++ (listModulesRec path fn)
        else if value == "regular" && name != "default.nix" && hasSuffix ".nix" name then
          [ (fn path) ]
        else
          [])
      (readDir dir));
}
