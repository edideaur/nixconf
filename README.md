# NixOS Configuration for ThinkPad T14 AMD (illogical-impulse Hyprland)

This repository contains a modular NixOS Flake configuration tailored specifically for the **Lenovo ThinkPad T14 Gen 1 (AMD Ryzen 5 PRO 4650U with Radeon Graphics)** running the **illogical-impulse** (`dots-hyprland`) Material 3 Expressive desktop environment powered by **QuickShell** and **Hyprland**.

---

## 🌟 Key Features

* **Bootloader**: **Limine** with custom high-res boot interface (2560x1440) and styled background.
* **Storage & Encryption**: **ZFS on LUKS2** declaratively configured with **Disko** (transparent `zstd` compression, 128k recordsizes, weekly TRIM, monthly auto-scrub).
* **Kernel & Optimization**: **CachyOS EEVDF Kernel** via Chaotic-Nyx with matching `zfs_cachyos`, `amd_pstate=active`, `amdgpu.ppfeaturemask=0xffffffff`, BBR TCP congestion control, CAKE queue discipline, 30GB ZRAM (`lz4`), and high-resolution PipeWire audio timers (`@audio rtprio 99`).
* **Desktop Environment**: **illogical-impulse** with QuickShell (Polkit integration, Kirigami, QtPositioning, wallpaper-derived dynamic theming via isolated Python `materialyoucolor`), custom vertical left bar, and the `drumkits_bg.webp` wallpaper.
* **Hardware & Peripherals**:
  * ThinkPad ACPI fan control and automatic lid logo LED shutoff.
  * S3 Deep Sleep (`mem_sleep_default=deep`) to prevent standby battery drain.
  * Synaptics Prometheus fingerprint reader (`06cb:00bd`) PAM authentication for login and screen lock.
  * External display (HDMI-A-1 2560x1440@144Hz) auto-switch and DDC/CI brightness control (`i2c-dev`).
* **Applications & Tooling**:
  * **Helium Browser** with native Wayland flags and Touchpad overscroll gestures.
  * **Alacritty** with JetBrainsMono Nerd Font and Shift+Enter fix.
  * **Spotify** patched declaratively with **SpotX-Bash** via `SpotX-Official/SpotX-Nix`.
  * **Equibop** (Discord client with Equicord), **Prism Launcher** (Java 21/17), **Zed Editor**, **fast-rm**, **Bun**, **Node.js 22**, **pnpm**, **rustup**, **Cloudflared**, and **Podman**.
  * **NextDNS** DNS-over-TLS via `systemd-resolved` with **Mullvad VPN** integration.

---

## 📁 Repository Structure

```
/home/edideaur/Documents/nix/
├── flake.nix                       # Flake entry point (inputs, outputs, overlays)
├── run-vm.sh                       # One-click helper to build and test in QEMU VM
├── hosts/
│   └── T14/
│       ├── default.nix             # Main host configuration (time, fonts, users, packages)
│       └── disko.nix               # Declarative ZFS on LUKS disk layout
├── modules/
│   ├── system/
│   │   ├── boot.nix                # Limine bootloader configuration
│   │   ├── kernel.nix              # CachyOS EEVDF kernel, ZFS modules, sysctl tuning
│   │   ├── hardware.nix            # AMDGPU, ThinkPad ACPI, TLP, Bluetooth, Fingerprint
│   │   ├── network.nix             # NetworkManager, NextDNS DoT, Mullvad, Warp
│   │   ├── audio.nix               # Low-latency PipeWire (128 samples / 2.6ms) & BlueZ codecs
│   │   ├── services.nix            # Greetd, tuigreet, ZRAM, Podman, Nix-LD, Geoclue2
│   │   └── vm.nix                  # QEMU / build-vm test overrides & 3D virtio acceleration
│   └── home/
│       ├── default.nix             # Home-Manager entry point for user edideaur
│       ├── packages.nix            # GUI & CLI packages (Helium, Alacritty, Zed, Spotify)
│       ├── shell.nix               # Fish configuration with custom aliases & Starship
│       ├── terminal.nix            # Alacritty & Kitty terminal configurations
│       ├── desktop-theme.nix       # GTK/Qt themes, Bibata cursor, mimeApps, config.json
│       ├── custom-hyprland.nix     # Keybinds (Super+T, Super+B, Super+Q), lid & monitor scripts
│       └── illogical-impulse.nix   # illogical-flake QuickShell & wallpaper theming
├── pkgs/
│   ├── fast-rm.nix                 # Fast Rust rm replacement derivation
│   └── microtex.nix                # MicroTeX LaTeX renderer for AI widget
└── assets/
    └── wallpapers/
        └── drumkits_bg.webp        # Default wallpaper asset
```

---

## 🧪 Testing in QEMU VM (Recommended First Step)

You can build and test the entire system safely in a virtual machine without altering your host drive:

```bash
cd /home/edideaur/Documents/nix
./run-vm.sh
```

Or manually:
```bash
nix build .#nixosConfigurations.T14.config.system.build.vm
./result/bin/run-T14-vm
```

* **Default Login**: User `edideaur` with initial password `nixos`.
* **Shared Directory**: Your host directory `/home/edideaur/Documents/nix` is accessible inside the VM at `/shared`.

---

## 🚀 Bare-Metal Installation (When Ready to Deploy)

1. **Boot from a NixOS Live USB** (24.11 or unstable).
2. **Clone / Copy this repository** to the live installer:
   ```bash
   git clone <repo-url> /mnt/etc/nixos
   ```
3. **Partition and format using Disko**:
   ```bash
   sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- \
     --mode zap_create_mount /mnt/etc/nixos/hosts/T14/disko.nix
   ```
4. **Install NixOS**:
   ```bash
   sudo nixos-install --flake /mnt/etc/nixos#T14
   ```
5. **Reboot**:
   ```bash
   reboot
   ```

---

## 🔄 Daily Maintenance Commands

* `nrs`: Rebuild and switch (`sudo nixos-rebuild switch --flake .#T14`)
* `nrt`: Test rebuild without bootloader update (`sudo nixos-rebuild test --flake .#T14`)
* `nru`: Update flake inputs (`nix flake update`)
* `ncg`: Clean up old generations (`nix-collect-garbage -d && sudo nix-collect-garbage -d`)
* `q`: Shorthand for QuickShell IPC (`qs -c ii`)
