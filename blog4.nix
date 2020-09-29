{ mkDerivation, aeson, attoparsec, base, blaze-html, cmark-gfm
, containers, lens, lens-aeson, mustache, shake, skylighting
, stdenv, text, time, unordered-containers, yaml, zlib
}:
mkDerivation {
  pname = "blog4";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    aeson attoparsec base blaze-html cmark-gfm containers lens
    lens-aeson mustache shake skylighting text time
    unordered-containers yaml
  ];
  executablePkgconfigDepends = [ zlib ];
  license = "unknown";
  hydraPlatforms = stdenv.lib.platforms.none;
}
