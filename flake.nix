{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
    hyprland.url = "github:hyprwm/Hyprland";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin-zen = {
      url = "github:catppuccin/zen-browser";
      flake = false;
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      catppuccin,
      home-manager,
      hyprland,
      zen-browser,
      ...
    }:
    {
      nixosConfigurations.whitezaziki = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./hosts/whitezaziki/configuration.nix

          catppuccin.nixosModules.catppuccin

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.andreas = {
              imports = [
                ./hosts/whitezaziki/home.nix
                catppuccin.homeModules.catppuccin
                hyprland.homeManagerModules.default
                zen-browser.homeModules.beta # <- add this
              ];
            };
          }
        ];
      };
    };
}
