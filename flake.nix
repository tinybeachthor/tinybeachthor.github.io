{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.09";
    haskellNix.url = "github:input-output-hk/haskell.nix/master";
  };
  outputs = { self, flake-utils, nixpkgs, haskellNix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = (import nixpkgs {
          inherit system;
          overlays = [ haskellNix.overlay ];
        });
        project = (import ./default.nix { inherit pkgs; });
        blog4 = project.blog4;
      in rec {
        defaultPackage = blog4.components.exes.blog4;
        packages = {
          plan-nix = project.plan-nix;
          materialize = project.updateMaterialized;
          blog4 = defaultPackage;
        };
        devShell = import ./shell.nix { inherit pkgs; };
      });
}
