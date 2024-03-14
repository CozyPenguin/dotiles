{ config, pkgs, inputs, lib, ... }:
{

  services.resolved.enable = true;
  networking.networkmanager.dns = "systemd-resolved";


  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16 * 1024;
  }];

  ############
  # Dual Boot
  ############

  # Fix windows clock
  time.hardwareClockInLocalTime = true;

  ###########
  # Packages
  ###########

  virtualisation.docker = {
    enable = true; 
    rootless = { 
      enable = true;
      setSocketVariable = true;
    };
  };
  virtualisation.libvirtd.enable = true;

  environment.systemPackages = with pkgs; [
    jetbrains.idea-ultimate
    unityhub
    graphviz

    maven
    gnumake

    # store docker credentials
    pass
    docker-credential-helpers

    inkscape
    xournalpp
    nextcloud-client
    filezilla

    # chess
    stockfish
    scid-vs-pc
  ];

  programs.java = {
    enable = true;
  };

  # Gnome

  modules.desktop.gnome.enable = true;
  services.xserver.libinput.enable = true;

  ###########
  # Security
  ###########

  security.tpm2 = {
    enable = true;
  };

  security.pki.certificateFiles = [ ./kit.pem ];

  ##########
  # Booting
  ##########

  boot.loader.timeout = 0;

  ##########
  # Drivers
  ##########

  # Firmware
  services.fwupd.enable = true;
}
