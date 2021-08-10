{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.09";
    haskellNix.url = "github:input-output-hk/haskell.nix/master";
  };
  outputs = { self, nixpkgs, haskellNix }:
    let
      supportedSystems = [ "x86_64-linux" ];

      # Function to generate a set based on supported systems
      forAllSystems = f:
        nixpkgs.lib.genAttrs supportedSystems (system: f system);

      nixpkgsFor = forAllSystems (system: import nixpkgs {
        inherit system;
        overlays = [ haskellNix.overlay ];
      });

    in {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
          project = (import ./default.nix { inherit pkgs; });
          blog4 = project.blog4;
        in {
          plan-nix = project.plan-nix;
          materialize = project.updateMaterialized;
          blog4 = blog4.components.exes.blog4;
        });
      defaultPackage = forAllSystems (system: self.packages.${system}.blog4);

      devShell = forAllSystems (system: import ./shell.nix {
        pkgs = nixpkgsFor.${system};
      });
    };
}
