with builtins;
let
  l = p.lib; p = pkgs;
  inherit (import ./inputs.nix) pkgs purescript-tidy purs-nix;

  package-json = l.importJSON (purescript-tidy + /package.json);

  purescript-tidy-patched =
    p.stdenv.mkDerivation
      rec
      { name = "purescript-tidy-patched";
        src = purescript-tidy;
        version = package-json.version;

        patchPhase =
          ''
          substituteInPlace bin/Bin/Version.js \
            --replace 'require("../../package.json").version' '"${version}"';
          '';

        installPhase = "mkdir out; cp -r ./. $out";
      };


  inherit (purs-nix) ps-pkgs purs;

  inherit
    (purs
       { dependencies =
           with ps-pkgs;
           with import ./extra-dependencies.nix purs-nix;
             [ aff
               argonaut-codecs
               argonaut-core
               argparse-basic
               arrays
               console
               control
               dodo-printer
               effect
               either
               foldable-traversable
               foreign-object
               lazy
               lists
               maybe
               newtype
               node-buffer
               node-fs
               node-fs-aff
               node-glob-basic
               node-path
               node-process
               node-streams
               node-workerbees
               ordered-collections
               parallel
               partial
               prelude
               psci-support
               purescript-language-cst-parser
               refs
               strings
               transformers
               tuples
             ];

         srcs =
           [ (purescript-tidy-patched + /src)
             (purescript-tidy-patched + /bin)
           ];
       }
    )
    modules;
in
modules.Main.install
  { name = package-json.name;
    auto-flags = false;
  }
