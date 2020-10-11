{ sources ? import ./nix/sources.nix }:

with { haskellNix = import sources."haskell.nix" { }; };

let
# haskell.nix provides access to the nixpkgs pins which are used by our CI,
# hence you will be more likely to get cache hits when using these.
# But you can also just use your own, e.g. '<nixpkgs>'.
nixpkgsSrc = haskellNix.sources.nixpkgs-2003;

# haskell.nix provides some arguments to be passed to nixpkgs, including some
# patches and also the haskell.nix functionality itself as an overlay.
nixpkgsArgs = haskellNix.nixpkgsArgs;

# import nixpkgs with overlays
pkgs = import nixpkgsSrc nixpkgsArgs;

in
pkgs.haskell-nix.project {
  # 'cleanGit' cleans a source directory based on the files known by git
  src = pkgs.haskell-nix.haskellLib.cleanGit {
    name = "haskell-nix-project";
    src = ./.;
  };
  # For `cabal.project` based projects specify the GHC version to use.
  compiler-nix-name = "ghc883"; # Not used for `stack.yaml` based projects.
}
