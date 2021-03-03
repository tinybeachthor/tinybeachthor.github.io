{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.09";
    tinybeachthor = {
      url = "github:tinybeachthor/nur-packages/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    haskellNix.url = "github:input-output-hk/haskell.nix/master";
  };
  outputs = { self, flake-utils, nixpkgs, tinybeachthor, haskellNix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = (import nixpkgs {
          inherit system;
          overlays = [ tinybeachthor.overlay haskellNix.overlay ];
        });
        project = (import ./default.nix { inherit pkgs; });
        blog4 = project.blog4;
      in rec {
        defaultPackage = blog4.components.exes.blog4;
        packages = {
          plan-nix = project.plan-nix;
          blog4 = defaultPackage;
        };
        devShell = import ./shell.nix { inherit pkgs; };
      });
}
