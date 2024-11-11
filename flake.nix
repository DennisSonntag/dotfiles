{
  description = "Home Manager configuration of dennis";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland"; # <- make sure this line is present for the plugin to work as intended
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixCats.url = "github:BirdeeHub/nixCats-nvim";
    # nixCats.url = "github:BirdeeHub/nixCats-nvim";

	 # myNeovimConfig = {
	 #     url = "path:./nvimFinal";
	 #     inputs.nixpkgs.follows = "nixpkgs";
	 #   };
    # myNixCats = import ./nvimFinal/flake.nix { inherit inputs; };

  };

  outputs = { self, nixpkgs, home-manager, split-monitor-workspaces, stylix,... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
      # pkgs = import nixpkgs { system = "x86_64-linux"; };
    in {
      nixosConfigurations = {
        archie = lib.nixosSystem {
	  system = "x86_64-linux";
          modules = [ ./configuration.nix  myNixCats stylix.nixosModules.stylix ];
        };
      };
      
      homeConfigurations."dennis" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ 
		  ./home.nix
		];
	    extraSpecialArgs = { inherit inputs; inherit split-monitor-workspaces; };

      };
    };
}
