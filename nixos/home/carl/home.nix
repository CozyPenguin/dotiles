{ config, pkgs, inputs, lib, stateVersion, ... }:
{
  home-manager.users.carl = {
    home = {
      inherit stateVersion;    
    };
  };
}
