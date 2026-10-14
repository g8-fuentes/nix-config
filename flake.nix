{
  description = "g8-space nix config";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixvim.url = "github:nix-community/nixvim/nixos-26.05";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
    stylix.url = "github:nix-community/stylix/release-26.05";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs-unstable";

    nixpkgs-droid.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager-droid.url = "github:nix-community/home-manager/release-24.05";
    home-manager-droid.inputs.nixpkgs.follows = "nixpkgs-droid";
    nix-on-droid.url = "github:nix-community/nix-on-droid/release-24.05";
    nix-on-droid.inputs.nixpkgs.follows = "nixpkgs-droid";
    nix-on-droid.inputs.home-manager.follows = "home-manager-droid";
    nixvim-droid.url = "github:nix-community/nixvim/nixos-24.05";
    nixvim-droid.inputs.nixpkgs.follows = "nixpkgs-droid";
    nixvim-droid.inputs.home-manager.follows = "home-manager-droid";
    stylix-droid.url = "github:nix-community/stylix/release-24.05";
    stylix-droid.inputs.nixpkgs.follows = "nixpkgs-droid";
    stylix-droid.inputs.home-manager.follows = "home-manager-droid";

  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      domain = "g8-space.com.br";
      forEachSystem = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forEachPkgs = f: forEachSystem (sys: f nixpkgs.legacyPackages.${sys});
    in
    {
      lib = import ./lib { inherit (nixpkgs) lib; };
      overlays = import ./overlays { inherit inputs outputs; };
      packages = forEachPkgs (pkgs: import ./pkgs { inherit pkgs; });
      devShells = forEachPkgs (pkgs: import ./shell.nix { inherit pkgs; });

      nixosConfigurations.sun = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs domain; };
        modules = [
          ./hosts/sun
          inputs.sops-nix.nixosModules.sops
          inputs.stylix.nixosModules.stylix
        ];
      };
      homeConfigurations."g8-fuentes@sun" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [
          inputs.sops-nix.homeModules.sops
          inputs.stylix.homeModules.stylix
          inputs.nixvim.homeModules.nixvim
          ./home/sun
        ];
      };

      nixOnDroidConfigurations.mercury = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import inputs.nixpkgs-droid {
          system = "aarch64-linux";
          overlays = [ inputs.nix-on-droid.overlays.default ];
        };
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [ ./hosts/mercury ];
      };
      homeConfigurations."nix-on-droid@localhost" = inputs.home-manager-droid.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs-droid.legacyPackages."aarch64-linux";
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [
          inputs.stylix-droid.homeManagerModules.stylix
          inputs.nixvim-droid.homeManagerModules.nixvim
          ./home/mercury
        ];
      };

      nixosConfigurations.jupiter = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./hosts/jupiter
          inputs.sops-nix.nixosModules.sops
          inputs.nixos-wsl.nixosModules.wsl
        ];
      };
      homeConfigurations."g8-fuentes@jupiter" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [
          inputs.sops-nix.homeModules.sops
          inputs.stylix.homeModules.stylix
          inputs.nixvim.homeModules.nixvim
          ./home/jupiter
        ];
      };

      darwinConfigurations."saturn" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./hosts/saturn
        ];
      };
      homeConfigurations."administrador@saturn" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."aarch64-darwin";
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [
          inputs.sops-nix.homeModules.sops
          inputs.stylix.homeModules.stylix
          inputs.nixvim.homeModules.nixvim
          ./home/saturn
        ];
      };

      darwinPackages = self.darwinConfigurations."saturn".pkgs;

      homeConfigurations."g8-fuentes@uranus" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [
          inputs.sops-nix.homeModules.sops
          inputs.stylix.homeModules.stylix
          inputs.nixvim.homeModules.nixvim
          ./home/uranus
        ];
      };
      nixosConfigurations.uranus = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          inputs.sops-nix.nixosModules.sops
          inputs.stylix.nixosModules.stylix
          ./hosts/uranus
        ];
      };

      homeConfigurations."g8-fuentes@neptune" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [
          inputs.sops-nix.homeModules.sops
          inputs.stylix.homeModules.stylix
          inputs.nixvim.homeModules.nixvim
          ./home/neptune
        ];
      };
      nixosConfigurations.neptune = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          inputs.sops-nix.nixosModules.sops
          inputs.stylix.nixosModules.stylix
          ./hosts/neptune
        ];
      };
    };
}
