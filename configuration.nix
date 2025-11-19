# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/monitors.nix
      ./modules/steam.nix
      ./modules/virtualization.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.displayManager.ly.enable = true;
  services.xserver = {
   enable = true;
   autoRepeatDelay = 200;
   autoRepeatInterval = 35;
   windowManager.i3 = {
     enable = true;
     package = pkgs.i3;
     extraPackages = with pkgs; [
	dmenu
	i3lock
	eww
	jq
	flameshot
	vscodium
     ];
   };
};

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cayazita = {
    isNormalUser = true;
    description = "cayazita";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  programs.nh = {
       enable = true;
       flake = "/etc/nixos"; 
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  programs.firefox.enable = true;
    # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  
  vscodium
  vscode
  qbittorrent
  nemo
  rofi
  cmatrix
  flameshot
  cava
  cbonsai
  jq
  eww
  neovim
  disfetch
  vesktop
  spotify
  alacritty
  prismlauncher
  pywal16
  git
  wget
  curl
  gcc
  killall
  i3status-rust
  picom
  feh
  btop
  autorandr
  ckan
  ];

fonts.packages = with pkgs; [
    jetbrains-mono
    hack-font
    fira-code
  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);


    services.picom = {
    enable = true;
    fade = true;
    shadow = true;
    fadeDelta = 4;
  };

  system.stateVersion = "25.05";

}
