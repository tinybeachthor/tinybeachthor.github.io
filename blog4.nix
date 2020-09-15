{ mkDerivation, aeson, attoparsec, base, cmark-gfm, containers
, lens, lens-aeson, mustache, shake, stdenv, text, time
, unordered-containers, yaml, zlib
}:
mkDerivation {
  pname = "blog4";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    aeson attoparsec base cmark-gfm containers lens lens-aeson mustache
    shake text time unordered-containers yaml
  ];
  executablePkgconfigDepends = [ zlib ];
  license = "unknown";
  hydraPlatforms = stdenv.lib.platforms.none;
}
