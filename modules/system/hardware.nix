{ pkgs, ... }:
{
  hardware.cpu.amd.updateMicrocode = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libvdpau-va-gl
    ];
  };

  # ThinkPad LED control: turn off lid logo LED dot on boot
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="leds", KERNEL=="tpacpi::lid_logo_dot", ATTR{brightness}="0"
    # DDC/CI monitor brightness control access for i2c group / video users
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';

  # Power Management - TLP optimized for ThinkPad T14
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      # Battery thresholds (100% full capacity requested)
      START_CHARGE_THRESH_BAT0 = 96;
      STOP_CHARGE_THRESH_BAT0 = 100;

      # NVMe power management
      PCIE_ASPM_ON_AC = "performance";
      PCIE_ASPM_ON_BAT = "powersave";

      # Keep Bluetooth powered on boot
      DEVICES_TO_ENABLE_ON_STARTUP = "bluetooth wifi";
    };
  };

  # NVMe I/O Scheduler: none for direct hardware queues
  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "nvme-scheduler-rules";
      destination = "/etc/udev/rules.d/60-nvme-scheduler.rules";
      text = ''
        ACTION=="add|change", KERNEL=="nvme[0-9]*n[0-9]*", ATTR{queue/scheduler}="none"
      '';
    })
  ];

  # Bluetooth with BlueZ 5 & experimental features (shows battery % in QuickShell)
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
    };
  };

  # Fingerprint reader support
  services.fprintd.enable = true;

  # Firmware updater for Lenovo ThinkPad UEFI & dock updates
  services.fwupd.enable = true;
}
