{ sources ? import ./nix/sources.nix }:

with { overlay = _: pkgs: {
  niv          = import sources.niv { };
}; };

with { pkgs = import sources.nixpkgs {
  overlays = [ overlay ];
  config = { };
}; };

rec {
  inherit pkgs;
  ghc-version = "ghc802";
}
