{ pkgs, ... }:
{
  imports = [
    ./disko.nix
    ../../modules/system/boot.nix
    ../../modules/system/kernel.nix
    ../../modules/system/hardware.nix
    ../../modules/system/network.nix
    ../../modules/system/audio.nix
    ../../modules/system/services.nix
    ../../modules/system/vm.nix
  ];

  # Time & Localization
  time.timeZone = "Europe/Bucharest";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_NUMERIC = "ro_RO.UTF-8";
    LC_TIME = "ro_RO.UTF-8";
    LC_MONETARY = "ro_RO.UTF-8";
    LC_PAPER = "ro_RO.UTF-8";
    LC_NAME = "ro_RO.UTF-8";
    LC_ADDRESS = "ro_RO.UTF-8";
    LC_TELEPHONE = "ro_RO.UTF-8";
    LC_MEASUREMENT = "ro_RO.UTF-8";
    LC_IDENTIFICATION = "ro_RO.UTF-8";
  };

  # Console keymap
  console.keyMap = "us";

  # Fonts
  fonts = {
    fontDir.enable = true;
    fontconfig = {
      enable = true;
      antialias = true;
      subpixel.rgba = "rgb";
      hinting = {
        enable = true;
        style = "slight";
      };
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" ];
        sansSerif = [ "Rubik" "Google Sans Flex" ];
        serif = [ "Liberation Serif" ];
      };
    };
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.ubuntu
      rubik
      google-fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      twemoji-color-font
      material-symbols
    ];
  };

  # System User configuration
  users.users.edideaur = {
    isNormalUser = true;
    description = "edideaur";
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "input"
      "i2c"
      "networkmanager"
      "podman"
    ];
    shell = pkgs.fish;
    initialPassword = "nixos"; # User should change this on first boot
  };

  # Enable Fish as system shell
  programs.fish.enable = true;

  # Enable ZSH as secondary shell
  programs.zsh.enable = true;

  # Environment variables (Global Wayland / Ozone)
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    EDITOR = "micro";
  };

  # System packages
  environment.systemPackages = with pkgs; [
    git
    micro
    nano
    curl
    wget
    pciutils
    usbutils
    lshw
    efibootmgr
    sbctl
    fast-rm
  ];

  # Allow unfree packages globally and provide backward-compatible overlay for deprecated icon themes
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (final: prev: {
      gnome-icon-theme = final.adwaita-icon-theme;
    })
  ];

  # Nix Package Manager settings & Substituters (Caches)
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      substituters = [
        "https://cache.nixos.org"
        "https://nyx-cache.chaotic.cx"
        "https://nix-community.cachix.org"
        "https://quickshell.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nyx-cache.chaotic.cx:dJxTrgMC3V3cFfyIiBQDQorG6k1LsqurH/srpMSq7qk="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "quickshell.cachix.org-1:Ak72y0Ocu2PD5WScFBPmNxIoasVoVoIViKGpmsOWFw4="
      ];
      trusted-users = [ "root" "edideaur" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  system.stateVersion = "25.05";
}
