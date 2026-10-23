{
  description = "NixOS + illogical-impulse Hyprland configuration for ThinkPad T14 AMD (ZFS, Limine, CachyOS EEVDF)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    illogical-flake = {
      url = "github:soymou/illogical-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };

    spotx-nix = {
      url = "github:SpotX-Official/SpotX-Nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium-browser = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{
    self,
    nixpkgs,
    chaotic,
    disko,
    home-manager,
    quickshell,
    illogical-flake,
    spotx-nix,
    helium-browser,
    ...
  }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        spotx-nix.overlays.default
        helium-browser.overlays.default
        (final: prev: {
          fast-rm = final.callPackage ./pkgs/fast-rm.nix { };
          microtex = final.callPackage ./pkgs/microtex.nix { };
          gnome-icon-theme = final.adwaita-icon-theme;
        })
      ];
    };
  in
  {
    nixosConfigurations.T14 = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        disko.nixosModules.disko
        chaotic.nixosModules.default
        ./hosts/T14
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.edideaur = import ./modules/home;
          };
        }
      ];
    };

    packages.${system} = {
      fast-rm = pkgs.fast-rm;
      microtex = pkgs.microtex;
      default = pkgs.fast-rm;
    };
  };
}
