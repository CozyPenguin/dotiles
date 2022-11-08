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

  ##############
  # Environment
  ##############

  environment.sessionVariables = {
    # Fix for VSCode on Wayland
    NIXOS_OZONE_WL = "1";

    # Firefox
    MOZ_ENABLE_WAYLAND = "1";
  };

  ###########
  # Packages
  ###########

  environment.systemPackages = with pkgs; [
    # Desktop Applications
    (discord.override {
      nss = nss_latest;
    })
    firefox-wayland

    # Terminal/Shell
    
    wezterm

    ## Cli

    bat
    broot
    dottor
    fzf
    wget
    zellij
    zoxide

    # GPG
    pinentry-gnome

    # Git
    git
    gh

    vscode
  ];

  # GnuPG
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };

  modules.desktop.gnome.enable = true;


  # Steam
  programs.steam = {
    enable = true;
  };

  # Fonts
  fonts.fonts = with pkgs; [
    fira-code
    (nerdfonts.override { 
      fonts = [ "FiraCode" ];
    })
  ];

  ###########
  # Security
  ###########

  security.tpm2 = {
    enable = true;
  };

  ##########
  # Drivers
  ##########

  # Nvidia proprietary
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
  };
  hardware.opengl.enable = true;

  # Firmware
  services.fwupd.enable = true;
}
