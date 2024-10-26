{
  description = "Dwm-x-Nix configuration for different systems I have";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {

    nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };

            modules = [
                ./system/configuration.nix
                home-manager.nixosModules.home-manager {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    users.user.user.isNormalUser = true;
                    home-manager.users.user = {
                        imports = [
                            ./home.nix
                        ];
                    };
                }
            ];
        };

        defaultIso = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            # XXX: I think this is here in case I want to add packages to nixos iso
        };
    };
  };
}
