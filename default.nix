{ pkgs }:

pkgs.haskell-nix.project {
  # 'cleanGit' cleans a source directory based on the files known by git
  src = pkgs.haskell-nix.haskellLib.cleanGit {
    name = "blog4-project";
    src = ./.;
  };
  # For `cabal.project` based projects specify the GHC version to use.
  compiler-nix-name = "ghc8101"; # Not used for `stack.yaml` based projects.
  index-state = "2020-10-10T00:00:00Z";
}
