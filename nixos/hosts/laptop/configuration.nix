{ config, pkgs, inputs, lib, ... }:
{
  # Enable networking
  networking.networkmanager.enable = true;
  services.resolved.enable = true;
  networking.firewall.allowedUDPPorts = [ 1194 ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

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
    jetbrains.idea-community
  ];

  programs.java = {
    enable = true;
    package = pkgs.jdk;
  };

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
