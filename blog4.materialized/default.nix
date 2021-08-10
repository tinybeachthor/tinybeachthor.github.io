{
  pkgs = hackage:
    {
      packages = {
        "void".revision = (((hackage."void")."0.7.3").revisions).default;
        "void".flags.safe = false;
        "semigroupoids".revision = (((hackage."semigroupoids")."5.3.4").revisions).default;
        "semigroupoids".flags.comonad = true;
        "semigroupoids".flags.doctests = true;
        "semigroupoids".flags.unordered-containers = true;
        "semigroupoids".flags.distributive = true;
        "semigroupoids".flags.tagged = true;
        "semigroupoids".flags.containers = true;
        "semigroupoids".flags.contravariant = true;
        "free".revision = (((hackage."free")."5.1.4").revisions).default;
        "exceptions".revision = (((hackage."exceptions")."0.10.4").revisions).default;
        "shake".revision = (((hackage."shake")."0.19.1").revisions).default;
        "shake".flags.portable = false;
        "shake".flags.embed-files = false;
        "shake".flags.cloud = false;
        "binary".revision = (((hackage."binary")."0.8.8.0").revisions).default;
        "ghc-prim".revision = (((hackage."ghc-prim")."0.6.1").revisions).default;
        "skylighting".revision = (((hackage."skylighting")."0.10.0.2").revisions).default;
        "skylighting".flags.executable = false;
        "utf8-string".revision = (((hackage."utf8-string")."1.0.1.1").revisions).default;
        "bifunctors".revision = (((hackage."bifunctors")."5.5.8").revisions).default;
        "bifunctors".flags.semigroups = true;
        "bifunctors".flags.tagged = true;
        "extra".revision = (((hackage."extra")."1.7.8").revisions).default;
        "split".revision = (((hackage."split")."0.2.3.4").revisions).default;
        "data-fix".revision = (((hackage."data-fix")."0.3.0").revisions).default;
        "stm".revision = (((hackage."stm")."2.5.0.0").revisions).default;
        "base-compat-batteries".revision = (((hackage."base-compat-batteries")."0.11.2").revisions).default;
        "case-insensitive".revision = (((hackage."case-insensitive")."1.2.1.0").revisions).default;
        "unix".revision = (((hackage."unix")."2.7.2.2").revisions).default;
        "mtl".revision = (((hackage."mtl")."2.2.2").revisions).default;
        "network-uri".revision = (((hackage."network-uri")."2.6.3.0").revisions).default;
        "rts".revision = (((hackage."rts")."1.0").revisions).default;
        "cmdargs".revision = (((hackage."cmdargs")."0.10.20").revisions).default;
        "cmdargs".flags.testprog = false;
        "cmdargs".flags.quotation = true;
        "js-flot".revision = (((hackage."js-flot")."0.8.3").revisions).default;
        "clock".revision = (((hackage."clock")."0.8").revisions).default;
        "clock".flags.llvm = false;
        "adjunctions".revision = (((hackage."adjunctions")."4.4").revisions).default;
        "invariant".revision = (((hackage."invariant")."0.5.4").revisions).default;
        "distributive".revision = (((hackage."distributive")."0.6.2").revisions).default;
        "distributive".flags.semigroups = true;
        "distributive".flags.tagged = true;
        "scientific".revision = (((hackage."scientific")."0.3.6.2").revisions).default;
        "scientific".flags.integer-simple = false;
        "scientific".flags.bytestring-builder = false;
        "parallel".revision = (((hackage."parallel")."3.2.2.0").revisions).default;
        "deepseq".revision = (((hackage."deepseq")."1.4.4.0").revisions).default;
        "random".revision = (((hackage."random")."1.2.0").revisions).default;
        "uuid-types".revision = (((hackage."uuid-types")."1.0.3").revisions).default;
        "splitmix".revision = (((hackage."splitmix")."0.1.0.1").revisions).default;
        "splitmix".flags.optimised-mixer = false;
        "dlist".revision = (((hackage."dlist")."1.0").revisions).default;
        "dlist".flags.werror = false;
        "conduit".revision = (((hackage."conduit")."1.3.2.1").revisions).default;
        "semigroups".revision = (((hackage."semigroups")."0.19.1").revisions).default;
        "semigroups".flags.bytestring = true;
        "semigroups".flags.unordered-containers = true;
        "semigroups".flags.text = true;
        "semigroups".flags.tagged = true;
        "semigroups".flags.containers = true;
        "semigroups".flags.binary = true;
        "semigroups".flags.hashable = true;
        "semigroups".flags.transformers = true;
        "semigroups".flags.deepseq = true;
        "semigroups".flags.bytestring-builder = false;
        "semigroups".flags.template-haskell = true;
        "parsec".revision = (((hackage."parsec")."3.1.14.0").revisions).default;
        "directory".revision = (((hackage."directory")."1.3.6.0").revisions).default;
        "hxt-regex-xmlschema".revision = (((hackage."hxt-regex-xmlschema")."9.2.0.3").revisions).default;
        "hxt-regex-xmlschema".flags.profile = false;
        "yaml".revision = (((hackage."yaml")."0.11.5.0").revisions).default;
        "yaml".flags.no-exe = true;
        "yaml".flags.no-examples = true;
        "transformers-compat".revision = (((hackage."transformers-compat")."0.6.6").revisions).default;
        "transformers-compat".flags.five = false;
        "transformers-compat".flags.generic-deriving = true;
        "transformers-compat".flags.two = false;
        "transformers-compat".flags.five-three = true;
        "transformers-compat".flags.mtl = true;
        "transformers-compat".flags.four = false;
        "transformers-compat".flags.three = false;
        "template-haskell".revision = (((hackage."template-haskell")."2.16.0.0").revisions).default;
        "mono-traversable".revision = (((hackage."mono-traversable")."1.0.15.1").revisions).default;
        "vector".revision = (((hackage."vector")."0.12.1.2").revisions).default;
        "vector".flags.unsafechecks = false;
        "vector".flags.internalchecks = false;
        "vector".flags.wall = false;
        "vector".flags.boundschecks = true;
        "call-stack".revision = (((hackage."call-stack")."0.2.0").revisions).default;
        "primitive".revision = (((hackage."primitive")."0.7.1.0").revisions).default;
        "profunctors".revision = (((hackage."profunctors")."5.6").revisions).default;
        "safe".revision = (((hackage."safe")."0.3.19").revisions).default;
        "skylighting-core".revision = (((hackage."skylighting-core")."0.10.0.2").revisions).default;
        "skylighting-core".flags.executable = false;
        "blaze-builder".revision = (((hackage."blaze-builder")."0.4.1.0").revisions).default;
        "base-compat".revision = (((hackage."base-compat")."0.11.2").revisions).default;
        "js-jquery".revision = (((hackage."js-jquery")."3.3.1").revisions).default;
        "time-compat".revision = (((hackage."time-compat")."1.9.3").revisions).default;
        "time-compat".flags.old-locale = false;
        "hxt".revision = (((hackage."hxt")."9.3.1.18").revisions).default;
        "hxt".flags.profile = false;
        "hxt".flags.network-uri = false;
        "ansi-terminal".revision = (((hackage."ansi-terminal")."0.11").revisions).default;
        "ansi-terminal".flags.example = false;
        "tagged".revision = (((hackage."tagged")."0.8.6").revisions).default;
        "tagged".flags.transformers = true;
        "tagged".flags.deepseq = true;
        "lens".revision = (((hackage."lens")."4.19.2").revisions).default;
        "lens".flags.j = false;
        "lens".flags.test-properties = true;
        "lens".flags.old-inline-pragmas = false;
        "lens".flags.test-templates = true;
        "lens".flags.trustworthy = true;
        "lens".flags.test-doctests = true;
        "lens".flags.benchmark-uniplate = false;
        "lens".flags.inlining = true;
        "lens".flags.dump-splices = false;
        "lens".flags.test-hunit = true;
        "lens".flags.safe = false;
        "unliftio-core".revision = (((hackage."unliftio-core")."0.2.0.1").revisions).default;
        "containers".revision = (((hackage."containers")."0.6.2.1").revisions).default;
        "integer-logarithms".revision = (((hackage."integer-logarithms")."1.0.3").revisions).default;
        "integer-logarithms".flags.check-bounds = false;
        "integer-logarithms".flags.integer-gmp = true;
        "reflection".revision = (((hackage."reflection")."2.1.6").revisions).default;
        "reflection".flags.slow = false;
        "reflection".flags.template-haskell = true;
        "these".revision = (((hackage."these")."1.1.1.1").revisions).default;
        "these".flags.assoc = true;
        "bytestring".revision = (((hackage."bytestring")."0.10.10.0").revisions).default;
        "cmark-gfm".revision = (((hackage."cmark-gfm")."0.2.2").revisions).default;
        "cmark-gfm".flags.pkgconfig = false;
        "lens-aeson".revision = (((hackage."lens-aeson")."1.1").revisions).default;
        "lens-aeson".flags.test-doctests = true;
        "heaps".revision = (((hackage."heaps")."0.3.6.1").revisions).default;
        "either".revision = (((hackage."either")."5.0.1.1").revisions).default;
        "StateVar".revision = (((hackage."StateVar")."1.2").revisions).default;
        "contravariant".revision = (((hackage."contravariant")."1.5.2").revisions).default;
        "contravariant".flags.semigroups = true;
        "contravariant".flags.tagged = true;
        "contravariant".flags.statevar = true;
        "blaze-markup".revision = (((hackage."blaze-markup")."0.8.2.7").revisions).default;
        "text".revision = (((hackage."text")."1.2.3.2").revisions).default;
        "Cabal".revision = (((hackage."Cabal")."3.2.0.0").revisions).default;
        "assoc".revision = (((hackage."assoc")."1.0.2").revisions).default;
        "unordered-containers".revision = (((hackage."unordered-containers")."0.2.13.0").revisions).default;
        "unordered-containers".flags.debug = false;
        "base64-bytestring".revision = (((hackage."base64-bytestring")."1.2.0.0").revisions).default;
        "base".revision = (((hackage."base")."4.14.0.0").revisions).default;
        "comonad".revision = (((hackage."comonad")."5.0.6").revisions).default;
        "comonad".flags.distributive = true;
        "comonad".flags.test-doctests = true;
        "comonad".flags.containers = true;
        "time".revision = (((hackage."time")."1.9.3").revisions).default;
        "mustache".revision = (((hackage."mustache")."2.3.1").revisions).default;
        "vector-algorithms".revision = (((hackage."vector-algorithms")."0.8.0.3").revisions).default;
        "vector-algorithms".flags.unsafechecks = false;
        "vector-algorithms".flags.internalchecks = false;
        "vector-algorithms".flags.llvm = false;
        "vector-algorithms".flags.boundschecks = true;
        "vector-algorithms".flags.bench = true;
        "vector-algorithms".flags.properties = true;
        "transformers".revision = (((hackage."transformers")."0.5.6.2").revisions).default;
        "hashable".revision = (((hackage."hashable")."1.3.0.0").revisions).default;
        "hashable".flags.sse2 = true;
        "hashable".flags.integer-gmp = true;
        "hashable".flags.sse41 = false;
        "hashable".flags.examples = false;
        "hxt-charproperties".revision = (((hackage."hxt-charproperties")."9.4.0.0").revisions).default;
        "hxt-charproperties".flags.profile = false;
        "attoparsec".revision = (((hackage."attoparsec")."0.13.2.4").revisions).default;
        "attoparsec".flags.developer = false;
        "blaze-html".revision = (((hackage."blaze-html")."0.9.1.2").revisions).default;
        "colour".revision = (((hackage."colour")."2.3.5").revisions).default;
        "transformers-base".revision = (((hackage."transformers-base")."0.4.5.2").revisions).default;
        "transformers-base".flags.orphaninstances = true;
        "file-embed".revision = (((hackage."file-embed")."0.0.13.0").revisions).default;
        "strict".revision = (((hackage."strict")."0.4").revisions).default;
        "strict".flags.assoc = true;
        "filepath".revision = (((hackage."filepath")."1.4.2.1").revisions).default;
        "process".revision = (((hackage."process")."1.6.8.2").revisions).default;
        "kan-extensions".revision = (((hackage."kan-extensions")."5.2.1").revisions).default;
        "th-lift".revision = (((hackage."th-lift")."0.8.2").revisions).default;
        "filepattern".revision = (((hackage."filepattern")."0.1.2").revisions).default;
        "libyaml".revision = (((hackage."libyaml")."0.1.2").revisions).default;
        "libyaml".flags.system-libyaml = false;
        "libyaml".flags.no-unicode = false;
        "resourcet".revision = (((hackage."resourcet")."1.2.4.2").revisions).default;
        "pretty".revision = (((hackage."pretty")."1.1.3.6").revisions).default;
        "hxt-unicode".revision = (((hackage."hxt-unicode")."9.0.2.4").revisions).default;
        "cabal-doctest".revision = (((hackage."cabal-doctest")."1.0.8").revisions).default;
        "aeson".revision = (((hackage."aeson")."1.5.4.1").revisions).default;
        "aeson".flags.cffi = false;
        "aeson".flags.fast = false;
        "aeson".flags.bytestring-builder = false;
        "aeson".flags.developer = false;
        "ghc-boot-th".revision = (((hackage."ghc-boot-th")."8.10.1").revisions).default;
        "base-orphans".revision = (((hackage."base-orphans")."0.8.3").revisions).default;
        "js-dgtable".revision = (((hackage."js-dgtable")."0.5.2").revisions).default;
        "th-abstraction".revision = (((hackage."th-abstraction")."0.4.0.0").revisions).default;
        "array".revision = (((hackage."array")."0.5.4.0").revisions).default;
        "integer-gmp".revision = (((hackage."integer-gmp")."1.0.3.0").revisions).default;
        };
      compiler = {
        version = "8.10.1";
        nix-name = "ghc8101";
        packages = {
          "exceptions" = "0.10.4";
          "binary" = "0.8.8.0";
          "ghc-prim" = "0.6.1";
          "stm" = "2.5.0.0";
          "unix" = "2.7.2.2";
          "mtl" = "2.2.2";
          "rts" = "1.0";
          "deepseq" = "1.4.4.0";
          "parsec" = "3.1.14.0";
          "directory" = "1.3.6.0";
          "template-haskell" = "2.16.0.0";
          "containers" = "0.6.2.1";
          "bytestring" = "0.10.10.0";
          "text" = "1.2.3.2";
          "Cabal" = "3.2.0.0";
          "base" = "4.14.0.0";
          "time" = "1.9.3";
          "transformers" = "0.5.6.2";
          "filepath" = "1.4.2.1";
          "process" = "1.6.8.2";
          "pretty" = "1.1.3.6";
          "ghc-boot-th" = "8.10.1";
          "array" = "0.5.4.0";
          "integer-gmp" = "1.0.3.0";
          };
        };
      };
  extras = hackage:
    { packages = { blog4 = ./.plan.nix/blog4.nix; }; };
  modules = [ ({ lib, ... }: { packages = { "blog4" = { flags = {}; }; }; }) ];
  }