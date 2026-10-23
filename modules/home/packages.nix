{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Core CLI & System Utilities
    fast-rm
    ripgrep
    fd
    jq
    eza
    bat
    fzf
    btop
    fastfetch
    gdu
    duf
    socat
    bc
    axel
    rsync
    cloudflared

    # Web & Internet
    helium
    mullvad-browser
    qbittorrent-nox

    # Media & Audio
    spotify-spotx
    cava
    obs-studio
    mpv
    playerctl
    easyeffects
    pavucontrol

    # Communication & Social
    equibop # Custom Discord desktop app with Equicord

    # Gaming & Java
    prismlauncher
    temurin-bin-21
    temurin-bin-17

    # Development Stack
    zed-editor
    rustup
    rust-analyzer
    nil # Nix language server
    nixd
    nixfmt-rfc-style
    bun
    nodejs_22
    pnpm
    python3
    python3Packages.pip
    gcc
    gnumake
    cmake
    pkg-config

    # Graphical Utilities
    kdePackages.dolphin
    kdePackages.kdialog
    wl-clipboard
    grim
    slurp
    swappy
    hyprpicker
    brightnessctl
    ddcutil
  ];
}
