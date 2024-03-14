{ config, pkgs, inputs, lib, stateVersion, ... }:
{
  #############
  # Networking
  #############

  networking.networkmanager.enable = true;
  networking.firewall.allowedUDPPorts = [
    1194 # KIT VPN
  ];

  services.printing.enable = true;

  ########
  # Sound
  ########

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
    extraGroups = [ "networkmanager" "wheel" "i2c" "docker" ];
  };

  users.groups = {
    i2c = { };
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
    firefox-wayland
    vlc
    onlyoffice-bin

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

    # Development

    dotnet-sdk_8
    lldb

    # GPG
    # pinentry-gnome

    # Git
    git
    git-lfs
    gh
    commitizen

    (vscode-with-extensions.override {
      vscodeExtensions = (with vscode-extensions; [
        matklad.rust-analyzer
        vadimcn.vscode-lldb
        vscode-extensions.ms-dotnettools.csharp
      ]) ++ (with vscode-marketplace; [
        # Theming
        pkief.material-icon-theme
        dracula-theme.theme-dracula
        usernamehw.errorlens
        avetis.tokyo-night
        wayou.vscode-todo-highlight
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons

        # Languages
        tamasfe.even-better-toml
        jnoortheen.nix-ide
        slevesque.shader

        asvetliakov.vscode-neovim
        streetsidesoftware.code-spell-checker
      ]);
    })

    # Gaming
    prismlauncher
    packwiz
  ];

  # GnuPG
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    # pinentryPackage = pkgs.;
  };

  # Fonts
  fonts.packages = with pkgs; [
    fira-code
    (nerdfonts.override {
      fonts = [ "FiraCode" ];
    })
  ];

  # Gaming
  programs.gamemode.enable = true;

  # dynamically linked stuff
  # services.nix-ld.enable = true;

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
}
