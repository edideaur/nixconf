{ config, pkgs, lib, ... }:
{
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192; # 8 GB RAM
      cores = 6;         # 6 vCPUs (matches 4650U physical cores)
      diskSize = 30720;  # 30 GB virtual disk
      graphics = true;
      qemu.options = [
        "-device" "virtio-vga-gl"
        "-display" "gtk,gl=on"
        "-audio" "driver=pa,model=virtio"
      ];
      sharedDirectories = {
        nix-config = {
          source = "/home/edideaur/Documents/nix";
          target = "/shared";
        };
      };
    };

    # Automatically adapt Disko drive inside VM
    disko.devices.disk.main.device = lib.mkVMOverride "/dev/vda";

    # In VM mode, use standard upstream kernel to avoid long local kernel compilations
    boot.kernelPackages = lib.mkVMOverride pkgs.linuxPackages_latest;
    boot.zfs.package = lib.mkVMOverride pkgs.zfs_latest;
  };
}
