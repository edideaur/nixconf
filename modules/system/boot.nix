{ pkgs, ... }:
{
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    limine = {
      enable = true;
      efiSupport = true;
      enableEditor = false;
      maxGenerations = 25;
      resolution = "2560x1440x32";
      style = {
        wallpaperStyle = "stretched";
        wallpapers = [ ../../assets/wallpapers/drumkits_bg.webp ];
        interface = {
          resolution = "2560x1440";
          branding = "NixOS // illogical-impulse (ThinkPad T14)";
        };
      };
    };
    timeout = 3;
  };
}
