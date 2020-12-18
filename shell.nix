{ pkgs }:

let
  project = import ./default.nix { inherit pkgs; };
in

project.shellFor {
  # Include only the *local* packages of your project.
  packages = ps: with ps; [
    blog4
  ];

  withHoogle = true;

  tools = {
    cabal = {
      version     = "3.2.0.0";
      index-state = "2020-10-10T00:00:00Z";
    };
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
