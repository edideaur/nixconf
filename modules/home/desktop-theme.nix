{ pkgs, ... }:
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
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
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
  home.file.".config/illogical-impulse/config.json".source =
    ../../assets/config/config.json;
}
