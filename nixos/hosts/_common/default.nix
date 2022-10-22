{ config, pkgs, inputs, lib, ... }:
{
  # Enable networking
  networking.networkmanager.enable = true;
  services.resolved.enable = true;
  networking.firewall.allowedUDPPorts = [ 
    1194 # KIT Vpn
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

    # GNOME
    gnome.gnome-tweaks
    gnomeExtensions.blur-my-shell
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.notification-banner-reloaded
    gnomeExtensions.pip-on-top
    gnomeExtensions.spotify-tray
    gnomeExtensions.pop-shell
    # Brightness control
    gnomeExtensions.brightness-control-using-ddcutil
    ddcutil

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

  # Flatpak

  services.flatpak.enable = true;
  xdg = {
    portal = {
      enable = true;
      gtkUsePortal = !config.services.xserver.desktopManager.gnome.enable;
    };
  };

  # GnuPG
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };

  # Desktop/Window Manager
  services.xserver = {
    enable = true; # Enable X11

    # use GNOME
    displayManager.gdm.enable = true;
    displayManager.defaultSession = "gnome";
    desktopManager.gnome.enable = true;
  };
  # Wayland stuff
  programs.xwayland.enable = true;

  # DDC
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';

  # GNOME
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

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

  # Firmware
  services.fwupd.enable = true;

  #########
  # Kernel
  #########

  boot = { 
    kernelPackages = pkgs.linuxPackages_latest; # Always use latest stable kernel
    kernelModules = [
      "i2c-dev" # for ddcutil to work
    ];
    supportedFilesystems = [ "ntfs" ];
    initrd.verbose = false;
  };

  #############
  # Booting
  #############

  boot.loader = { 
    systemd-boot = {
      enable = true; 
      consoleMode = "max";
      configurationLimit = 25;
    };
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot/efi";
  };

  system.stateVersion = "22.05"; 
}
