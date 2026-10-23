{ ... }:
{
  imports = [
    ./packages.nix
    ./shell.nix
    ./terminal.nix
    ./desktop-theme.nix
    ./custom-hyprland.nix
    ./illogical-impulse.nix
  ];

  home = {
    username = "edideaur";
    homeDirectory = "/home/edideaur";
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}
