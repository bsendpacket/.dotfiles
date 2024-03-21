{ 
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    system-manager,
    nixvim,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    systemConfigs.default = system-manager.lib.makeSystemConfig {
      modules = [
        /home/remnix/.dotfiles/modules
      ];
    };

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#remnix'
    nixosConfigurations = {
      remnix = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        # > Our main nixos configuration file <
        modules = [
          ./nixos/configuration.nix
        ];
      };

      remnixISO = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          /home/remnix/.dotfiles/iso/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      # NixOS home configuration setup lives in
      # nixos-config/default.nix and their respective host-specific
      # modules.

      remnix = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        username = "remnix";
        homeDirectory = "/home/remnix";

        configuration = /home/remnix/.dotfiles/home-manager/home.nix; 
        extraSpecialArgs.flake-inputs = inputs;
      };
    };

    packages.x86_64-linux = {
      inherit self;
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      flake-inputs = inputs;
    };
  };
}
