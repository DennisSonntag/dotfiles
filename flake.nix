{
  description = "Home Manager configuration of dennis";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #pyprland.url = "github:hyprland-community/pyprland";
    #hyprland.url = "github:hyprwm/Hyprland";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland"; # <- make sure this line is present for the plugin to work as intended
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags.url = "github:Aylur/ags";
  };

  #outputs = { self, nixpkgs, home-manager, pyprland, ... }@inputs:
  outputs = { self, nixpkgs, home-manager, split-monitor-workspaces, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        archie = lib.nixosSystem {
	  #environment.systemPackages = [ pyprland.packages."x86_64-linux".pyprland ];
	  system = "x86_64-linux";
          modules = [ ./configuration.nix ];
        };
      };
      
      homeConfigurations."dennis" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ 
	  ./home.nix
	  inputs.ags.homeManagerModules.default
	];
	extraSpecialArgs = { inherit inputs; inherit split-monitor-workspaces; };

      };
    };
}
