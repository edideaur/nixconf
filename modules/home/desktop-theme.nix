{ pkgs, personal, ... }:
{
  # Chromium / Helium Ozone Wayland flags
  home.file.".config/chrome-flags.conf".text = ''
    --ozone-platform-hint=wayland
    --gtk-version=4
    --ignore-gpu-blocklist
    --enable-features=TouchpadOverscrollHistoryNavigation
    --enable-wayland-ime
    --password-store=gnome-libsecret
  '';

  # Zed flags / code flags
  home.file.".config/code-flags.conf".text = ''
    --ozone-platform-hint=wayland
    --gtk-version=4
    --ignore-gpu-blocklist
    --enable-features=TouchpadOverscrollHistoryNavigation
    --enable-wayland-ime
    --password-store=gnome-libsecret
  '';

  # Cursor theme: Bibata-Modern-Classic size 24
  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # GTK Theme
  gtk = {
    enable = true;
    gtk4.theme = null;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "OneUI-dark";
      package = null; # handled by illogical-impulse dotfiles module
    };
    font = {
      name = "Rubik";
      size = 11;
    };
  };

  # Qt Platform Theme (qt6ct)
  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
  };

  # XDG Mime Default Applications
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "helium.desktop";
      "x-scheme-handler/http" = "helium.desktop";
      "x-scheme-handler/https" = "helium.desktop";
      "x-scheme-handler/about" = "helium.desktop";
      "x-scheme-handler/unknown" = "helium.desktop";
      "inode/directory" = "org.kde.dolphin.desktop";
      "image/png" = "org.kde.gwenview.desktop";
      "image/jpeg" = "org.kde.gwenview.desktop";
      "video/mp4" = "mpv.desktop";
      "video/mkv" = "mpv.desktop";
    };
  };

  # Seed wallpaper into user directory
  home.file."Documents/drumkits_bg.webp".source = ../../assets/wallpapers/drumkits_bg.webp;

  # Seed your customized illogical-impulse config.json
  # (Vertical left bar, monochrome palette, drumkits_bg wallpaper, custom toggles, AI settings)
  # Personal paths in the template are substituted from personal.nix.
  home.file.".config/illogical-impulse/config.json".text =
    builtins.replaceStrings [ "/home/edideaur" ] [ personal.homeDirectory ]
      (builtins.readFile ../../assets/config/config.json);

  # QuickShell state is intentionally not seeded; it regenerates at runtime.

  # Ensure icon name compatibility symlinks for pavucontrol and other apps
  xdg.dataFile."icons/hicolor/48x48/apps/pavucontrol.svg".source =
    "${pkgs.papirus-icon-theme}/share/icons/Papirus/48x48/apps/org.pulseaudio.pavucontrol.svg";
  xdg.dataFile."icons/hicolor/48x48/apps/org.pulseaudio.pavucontrol.svg".source =
    "${pkgs.papirus-icon-theme}/share/icons/Papirus/48x48/apps/org.pulseaudio.pavucontrol.svg";
  xdg.dataFile."icons/hicolor/48x48/apps/multimedia-volume-control.svg".source =
    "${pkgs.papirus-icon-theme}/share/icons/Papirus/48x48/apps/multimedia-volume-control.svg";
}
