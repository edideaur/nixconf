{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_cachyos-eevdf;
  boot.zfs.package = pkgs.zfs_cachyos;

  boot.kernelParams = [
    "amd_pstate=active"
    "amdgpu.ppfeaturemask=0xffffffff"
    "idle=nomwait"
    "iommu=pt"
    "mem_sleep_default=deep"
    "nowatchdog"
    "quiet"
    "splash"
    "transparent_hugepage=always"
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "thunderbolt"
    "usb_storage"
    "sd_mod"
    "amdgpu"
    "r8169"
  ];

  boot.kernelModules = [
    "kvm-amd"
    "amdgpu"
    "thinkpad_acpi"
    "i2c-dev"
    "wireguard"
    "tcp_bbr"
    "snd_seq"
    "snd_hrtimer"
    "vhost_net"
    "vhost_vsock"
    "btusb"
  ];

  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=0 power_save_controller=N
    options snd_soc_nau8821 power_save=0
    options thinkpad_acpi fan_control=1
  '';

  boot.kernel.sysctl = {
    # Virtual Memory & ZRAM
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
    "vm.dirty_ratio" = 10;
    "vm.dirty_background_ratio" = 5;

    # Inotify watches for Zed / Rust / Node dev
    "fs.inotify.max_user_watches" = 1048576;
    "fs.inotify.max_user_instances" = 1024;

    # Network low-latency & throughput (BBR + CAKE)
    "net.core.default_qdisc" = "cake";
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.ipv4.tcp_fastopen" = 3;
    "net.ipv4.tcp_slow_start_after_idle" = 0;
    "net.ipv4.tcp_syncookies" = 1;
    "net.core.rmem_max" = 16777216;
    "net.core.wmem_max" = 16777216;
  };

  # Disable core dumps to protect SSD longevity
  systemd.coredump.enable = false;
}
