{ mkDerivation, aeson, base, containers, lens, lens-aeson, mustache
, shake, slick, stdenv, text, time, unordered-containers, zlib
}:
mkDerivation {
  pname = "blog4";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    aeson base containers lens lens-aeson mustache shake slick text
    time unordered-containers
  ];
  executablePkgconfigDepends = [ zlib ];
  license = "unknown";
  hydraPlatforms = stdenv.lib.platforms.none;
}
