{ config, pkgs, inputs, lib, ... }:
{
  # Enable networking
  networking.networkmanager.enable = true;
  services.resolved.enable = true;
  networking.firewall.allowedUDPPorts = [ 1194 ];

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

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
  environment.gnome.excludePackages = with pkgs.gnome; [
    gnome-software
    epiphany
  ];

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
