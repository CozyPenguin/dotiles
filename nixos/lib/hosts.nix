# hlissner/dotfiles (once again)
{ inputs, lib, pkgs, ... }:
let
  inherit (lib.my) mapToList;
  inherit (lib) mapAttrs' nameValuePair nixosSystem id mkDefault;
  inherit (builtins) map listToAttrs readDir;
  sys = "x86_64-linux";
in {
  # mapHosts :: Path -> AttrSet -> AttrSet
  mapHosts = dir: attrs @ { system ? sys, ... }:
    mapAttrs'
      (name: value:
        let path = "${toString dir}/${name}"; in
        if value == "directory" && name != "_common" then
          nameValuePair name (nixosSystem {
            inherit system;
            specialArgs = { inherit pkgs inputs lib; };
            modules = 
              [{
                networking.hostName = mkDefault name;
              }] ++
              mapToList path id ++ 
              mapToList "${toString dir}/_common" id ++
              mapToList ../modules id;
          })
        else
          nameValuePair "" null)
      (readDir dir);
}
