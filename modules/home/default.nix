{ personal, ... }:
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
    username = personal.username;
    homeDirectory = personal.homeDirectory;
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}
