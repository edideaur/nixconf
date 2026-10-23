{ inputs, lib, ... }:
{
  imports = [
    inputs.illogical-flake.homeManagerModules.default
  ];

  programs.illogical-impulse = {
    enable = true;

    dotfiles = {
      fish.enable = lib.mkForce true;
      kitty.enable = lib.mkForce true;
      starship.enable = lib.mkForce true;
    };
  };
}
