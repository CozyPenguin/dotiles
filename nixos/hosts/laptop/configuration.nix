{ config, pkgs, inputs, lib, ... }:
{

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

  environment.systemPackages = with pkgs; [
    jetbrains.idea-ultimate
    graphviz
    jetbrains.rider
    maven

    krita
    xournalpp
    nextcloud-client
    filezilla
  ];

  programs.java = {
    enable = true;
    package = pkgs.jetbrains.jdk;
  };

  # Gnome

  modules.desktop.gnome.enable = true;

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
