{ config, pkgs, inputs, lib, ... }:
{
  # Enable networking
  networking.networkmanager.enable = true;
  services.resolved.enable = true;
  networking.firewall.allowedUDPPorts = [ 
    1194 # KIT VPN
  ];

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

  ##############
  # Environment
  ##############

  environment.sessionVariables = {
    # Fix for VSCode on Wayland
    NIXOS_OZONE_WL = "1";

    # Firefox
    MOZ_ENABLE_WAYLAND = "1";
  };


  #################
  # Users & Groups
  #################

  users.defaultUserShell = pkgs.nushell;

  # User list
  users.users.carl = {
    isNormalUser = true;
    description = "Carl Schierig";
    extraGroups = [ "networkmanager" "wheel" "i2c" ];
  };

  users.groups = {
    i2c = {};
  };

  ###############
  # Localisation
  ###############

  modules.localisation = {
    timeZone = "Europe/Berlin";
    language = {
      system = "en_GB";
      formats = "de_DE";
    };
  };

  ###########
  # Packages
  ###########

  # Binary caches
  nix.settings.substituters = [ "https://nix-community.cachix.org" ];
  nix.settings.trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];

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
    fend
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

  # Fonts
  fonts.fonts = with pkgs; [
    fira-code
    (nerdfonts.override { 
      fonts = [ "FiraCode" ];
    })
  ];

  ##########
  # Drivers
  ##########

  # Firmware
  services.fwupd.enable = true;

  #########
  # Kernel
  #########

  boot = { 
    kernelPackages = pkgs.linuxPackages_latest; # Always use latest stable kernel
    supportedFilesystems = [ "ntfs" ];
    initrd.verbose = false;
  };

  #############
  # Booting
  #############

  boot.loader = { 
    systemd-boot = {
      enable = true; 
      configurationLimit = 25;
    };
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot/efi";
  };

  system.stateVersion = "22.05"; 
}
