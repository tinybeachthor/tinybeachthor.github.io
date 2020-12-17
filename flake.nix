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
      in {
        defaultPackage =
          (import ./default.nix { inherit pkgs; }).blog4.components.exes.blog4;
        devShell = import ./shell.nix { inherit pkgs; };
      });
}
