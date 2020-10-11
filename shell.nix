{ sources ? import ./nix/sources.nix }:

with { overlay = _: pkgs: {
  niv          = import sources.niv { };
}; };

with import sources.nixpkgs {
  overlays = [ overlay ];
  config = { };
};

mkShell {
  buildInputs = [
    git
    gnumake
    cachix

    haskellPackages.ghcide
    haskellPackages.brittany

    nodePackages.serve
  ];
}
