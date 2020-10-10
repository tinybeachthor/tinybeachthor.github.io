{
  main = "Main";
  src = ./app;

  dependencies = [
    "aeson"
    "attoparsec"
    "base"
    "blaze-html"
    "cmark-gfm"
    "containers"
    "lens"
    "lens-aeson"
    "mustache"
    "shake"
    "skylighting"
    "text"
    "time"
    "unordered-containers"
    "yaml"
  ];
  packages = [ zlib ];
}
