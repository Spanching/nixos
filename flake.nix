{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix/release-25.05";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = { nixpkgs, catppuccin, home-manager, hyprland, hyprland-plugins, ... }: {
    nixosConfigurations.whitezaziki = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      
      modules = [
        ./hosts/whitezaziki/configuration.nix
        
        catppuccin.nixosModules.catppuccin

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit hyprland-plugins; };
          home-manager.users.andreas = {
            imports = [
              ./hosts/whitezaziki/home.nix
              catppuccin.homeModules.catppuccin
              hyprland.homeManagerModules.default
            ];
          };
        }
      ];
    };
  };
}
