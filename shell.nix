{ sources ? import ./nix/sources.nix }:

let
  overlay = _: pkgs: {
    niv = import sources.niv { };
  };

  pkgs = import sources.nixpkgs {
    overlays = [ overlay ];
    config = { };
  };

  hsPkgs = import ./default.nix { };
in

hsPkgs.shellFor {
  # Include only the *local* packages of your project.
  packages = ps: with ps; [
    blog4
  ];

  withHoogle = true;

  tools = {
    cabal = "3.2.0.0";
  };

  buildInputs = with pkgs; [
    git
    gnumake
    cachix

    haskellPackages.haskell-language-server
    haskellPackages.brittany

    nodePackages.serve
  ];

  exactDeps = true;
}
