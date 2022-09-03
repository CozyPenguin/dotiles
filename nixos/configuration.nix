{ config, pkgs, inputs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix # Include the results of the hardware scan.
  ];

  networking.hostName = "carl-schierig"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

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

    # Set default editor
    EDITOR = "nvim";
  };


  #################
  # Users & Groups
  #################

  users.defaultUserShell = pkgs.unstable.nushell;

  # User list
  users.users.carl = {
    isNormalUser = true;
    description = "Carl Schierig";
    extraGroups = [ "networkmanager" "wheel" "i2c" "tss" ];
  };

  users.groups = {
    i2c = {};
    tss = {};
  };

  ###############
  # Localisation
  ###############

  # Time zone.
  time.timeZone = "Europe/Berlin";

  # Locales
  i18n = {
    defaultLocale = "en_GB.utf8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.utf8";
      LC_IDENTIFICATION = "de_DE.utf8";
      LC_MEASUREMENT = "de_DE.utf8";
      LC_MONETARY = "de_DE.utf8";
      LC_NAME = "de_DE.utf8";
      LC_NUMERIC = "de_DE.utf8";
      LC_PAPER = "de_DE.utf8";
      LC_TELEPHONE = "de_DE.utf8";
      LC_TIME = "de_DE.utf8";
    };
  };

  # Keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "";
  };
  console.keyMap = "de"; # Console keymap

  ###########
  # Packages
  ###########

  environment.systemPackages = ( with pkgs; [
    # Desktop Applications

    discord
    firefox-wayland

    # GNOME
    gnome.gnome-tweaks
    unstable.gnomeExtensions.blur-my-shell
    unstable.gnomeExtensions.tray-icons-reloaded
    unstable.gnomeExtensions.notification-banner-reloaded
    unstable.gnomeExtensions.pip-on-top
    unstable.gnomeExtensions.spotify-tray
    # Brightness control
    unstable.gnomeExtensions.brightness-control-using-ddcutil
    ddcutil

    # Terminal/Shell

    unstable.nushell
    starship
    wezterm

    ## Cli

    bat
    wget
    unzip
    my.dottor

    # Development

    # Editors
    vscode

    # GPG
    pinentry-gnome

    # Git
    git
    gh

    ## Programming Languages
    
    # C/C++
    gcc
    gdb

    # JavaScript
    nodejs

    # Rust
    rustup
    pkg-config

    python3

    # Misc
    wl-clipboard
  ] );

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

    # use Plasma
    # displayManager.sddm.enable = true;
    # desktopManager.plasma5.enable = true;
  };
  # Wayland stuff
  programs.xwayland.enable = true;

  # DDC
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';

  # GNOME
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  
  # Nushell
  environment.shells = [ pkgs.unstable.nushell ];

  # Neovim
  

  # Neovim
  # programs.neovim = {
  #   enable = true;
  #   package = pkgs.unstable.neovim-unwrapped;
  #   vimAlias = true;
  #   defaultEditor = true;
  #   configure = { 
  #     customRC =  ''
  #       :if filereadable($HOME."/.config/nvim/init.lua")
  #       :  luafile $HOME/.config/nvim/init.lua
  #       :endif
  #     ''; 
  #   };
  # };

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

  #########
  # Kernel
  #########

  boot = { 
    kernelPackages = pkgs.linuxPackages_latest; # Always use latest stable kernel
    kernelModules = [
      "i2c-dev" # for ddcutil to work
    ];
    kernelParams = [
      "quiet"
      "rd.systemd.show_status=auto"
      "rd.udev.log_level=3"
      "rd.udev.log_priority=3"
    ];
    supportedFilesystems = [ "ntfs" ];
    initrd.verbose = false;
    consoleLogLevel = 0;
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

  boot.plymouth = {
    enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  ######
  # Nix
  ######

  # nix
  nix = { 
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    # Enable automatic GC
    gc = {
      automatic = true;
      dates = "weekly";
    };
    settings.auto-optimise-store = true;
  };
}
