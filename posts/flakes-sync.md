---
title: Synchronize flake inputs
description: How to not end up with 20 different compiler versions
date: Jun 22, 2022
tags: [ nix, flakes ]

---

# Synchronize flake inputs

When working across multiple rust crates, of course as nix flakes, 
it is very easy to end up with multiple minor versions of the toolchain.
Which is annoying and does not help all that much at all - 
the strong nix reproducibility is a nuisance in this case.

## Solution

Using a super-flake to re-export the packages we can get the same version
of the toolchain for multiple crate flakes.

The super-flake will look something like this:

```nix
{
  inputs = {
    flake-utils.url = github:numtide/flake-utils/master;
    nixpkgs.url = github:NixOS/nixpkgs/nixos-22.05;
    rust-overlay = {
      url = github:oxalica/rust-overlay/master;
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs = { self, flake-utils, nixpkgs, rust-overlay }:
    {
      lib = flake-utils.lib;
    }
    //
    flake-utils.lib.eachDefaultSystem (system: rec
    {
      packages = (import nixpkgs {
        inherit system;
        overlays = [
          rust-overlay.overlay
        ];
      });
    }); 
}
```

We re-export the `nixpkgs` with `rust-overlay` applied, 
and also `flake-utils.lib` for convenience.

The usage is simple:

```nix
{
  inputs = {
    nix.url = github:${REPO_OWNER}/${REPO_NAME}/master;
  };

  outputs = { self, nix }:
    with nix.lib;
    eachSystem [ system.x86_64-linux ] (system: {
      devShell = import ./shell.nix {
        pkgs = nix.packages.${system};
      };
  });
}
```

## Bonus: auto-update

To auto update the input we can add the following command to the end of 
[.envrc](https://direnv.net/):

```sh
nix flake update nix --commit-lock-file
```
