{ config, pkgs, ... }:

{
  imports =
    [
      # Import hardware configuration
      ./hardware-configuration.nix
    ];

  # Allow non-free software :(
  nixpkgs.config.allowUnfree = true;

  # Use EFI boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "suzumiya";
  networking.networkmanager.enable = true;  

  # Set locales
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Time zone
  time.timeZone = "Asia/Jakarta";

  # System packages
  environment.systemPackages = with pkgs; [
    wget
    curl
    vim
    emacs
    firefox
    git
    zsh
    maim
    slop
    python35Packages.docker_compose
    python3
    python35Packages.pip
    python27Full
    python27Packages.pip
    ruby
    bundler
    go
    mpv
    tdesktop
    screenfetch
    keepassx2-http
    guile
    pltScheme
    libreoffice-fresh
    openjdk
    eclipses.eclipse-sdk-46
    steam
    cryptsetup
    ntfs3g
    exfat
    paper-gtk-theme
    paper-icon-theme
  ];

  # Fonts
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      hack-font # For emacs and terminal emulators
      google-fonts # For mostly design or documents
      vistafonts # For Microsoft Office documents
    ];
  };

  # X Server stuff
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # NVIDIA is disabled due to problems with GLX :(
  services.xserver.videoDrivers = [ "intel" ];

  # GNOME 3
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;

  # DNSCrypt
  services.dnscrypt-proxy.enable = true; 

  # Docker
  virtualisation.docker.enable = true;

  # Set zsh as the one and only shell :)
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

  # Yuki <3
  users.extraUsers.yuki = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
  };

  system.stateVersion = "16.09";
}
