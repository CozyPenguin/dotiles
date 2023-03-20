{ config, pkgs, inputs, lib, ... }:
{
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
    xournalpp
    nextcloud-client
  ];

  programs.java = {
    enable = true;
    package = pkgs.openjdk17-bootstrap;
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

  # hardware.sensor.iio.enable = true;
}
