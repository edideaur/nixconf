{ pkgs, ... }:
{
  # ZFS maintenance services
  services.zfs = {
    autoScrub = {
      enable = true;
      interval = "monthly";
    };
    trim = {
      enable = true;
      interval = "weekly";
    };
  };

  # ZRAM in-memory compressed swap
  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 100; # 32 GB ZRAM pool
    priority = 100;
  };

  # Geoclue2 with demo agent enabled for QuickShell weather & location
  services.geoclue2 = {
    enable = true;
    enableDemoAgent = true;
  };

  # Systemd Journal limits (prevent SSD log bloat)
  services.journald.settings = {
    Journal = {
      SystemMaxUse = "500M";
      RuntimeMaxUse = "100M";
    };
  };

  # GNOME Keyring daemon with PAM auto-unlock
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.hyprlock.fprintAuth = true;

  # Greetd + tuigreet
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-user-session --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  # Gamemode daemon
  programs.gamemode.enable = true;

  # Nix-LD for unpatched prebuilt binaries (cargo builds, bun, rustc, etc.)
  programs.nix-ld.enable = true;

  # Enable dconf
  programs.dconf.enable = true;

  # Upower daemon for battery tracking
  services.upower.enable = true;

  # Podman (Rootless container virtualization)
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
}
