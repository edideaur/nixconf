{ config, pkgs, lib, ... }:
{
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192; # 8 GB RAM
      cores = 6;         # 6 vCPUs (matches 4650U physical cores)
      diskSize = 30720;  # 30 GB virtual disk
      graphics = true;
      qemu.options = [
        "-device" "virtio-vga"
        "-display" "gtk"
      ];
      forwardPorts = [
        { from = "host"; host.port = 2222; guest.port = 22; }
      ];
      sharedDirectories = {
        nix-config = {
          source = "/home/edideaur/Documents/nix";
          target = "/shared";
        };
      };
    };

    # Enable SSH inside VM for headless/terminal access from host
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "yes";
        PasswordAuthentication = true;
      };
    };

    # Automatically adapt Disko drive inside VM
    disko.devices.disk.main.device = lib.mkVMOverride "/dev/vda";

    # In VM mode, use standard upstream kernel to avoid long local kernel compilations
    boot.kernelPackages = lib.mkVMOverride pkgs.linuxPackages_latest;
    boot.zfs.package = lib.mkVMOverride pkgs.zfs_latest;
  };
}
