{ inputs, ... }:
{
  imports = [
    inputs.illogical-flake.homeManagerModules.default
  ];

  programs.illogical-impulse = {
    enable = true;

    dotfiles = {
      fish.enable = false;    # Handled by our dedicated shell.nix
      kitty.enable = false;   # Handled by our dedicated terminal.nix
      starship.enable = false;# Handled by our dedicated shell.nix
    };
  };
}
