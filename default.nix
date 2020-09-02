{ sources ? import ./nix/sources.nix }:

with { overlay = _: pkgs: {
  niv          = import sources.niv { };
}; };

with import sources.nixpkgs {
  overlays = [ overlay ];
  config = { };
};

haskell.packages.ghc883.callPackage ./blog.nix {
  inherit zlib;
}
