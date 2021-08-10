{ pkgs }:

with pkgs.haskell-nix;

project {
  # 'cleanGit' cleans a source directory based on the files known by git
  src = haskellLib.cleanGit {
    name = "blog4-project";
    src = ./.;
  };
  # For `cabal.project` based projects specify the GHC version to use.
  compiler-nix-name = "ghc8101"; # Not used for `stack.yaml` based projects.
  index-state = "2020-10-10T00:00:00Z";
  plan-sha256 = "0q33yygblhnfczxczc3vdr9yncqfqwjrvf8b739svy2isgaqc8bb";
  materialized = ./blog4.materialized;
}
