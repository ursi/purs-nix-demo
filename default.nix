with builtins;
let
  l = p.lib; p = pkgs;

  pkgs =
    import
      (fetchTarball
         { url = "https://github.com/NixOS/nixpkgs/archive/6525bbc06a39f26750ad8ee0d40000ddfdc24acb.tar.gz";
           sha256 = "1irrvwzfj37awf0l7ww4n5dbs7scf7jkb436gwgyzs1bn4r5w7nq";
         }
      )
      {};

  purs-nix =
    import
      (fetchGit
         { url = "https://github.com/ursi/purs-nix.git";
           rev = "a88bb002ba092ce665042a0d98136c076e253b79";
         }
      )
      {};

  purescript-tidy-patched =
    let
      src =
        fetchGit
          { url = "https://github.com/natefaubion/purescript-tidy.git";
            ref = "main";
            rev = "f4723287f9ea0d355e7bbdb549b85bfd3487a549";
          };

      version = (l.importJSON (src + /package.json)).version;
    in
    pkgs.stdenv.mkDerivation
      { name = "purescript-tidy-patched";
        inherit src;

        patchPhase =
          ''
          substituteInPlace bin/Bin/Version.js \
            --replace 'require("../../package.json").version' '"${version}"';
          '';

        installPhase = "mkdir out; cp -r ./. $out";
      };


  inherit (purs-nix) build ps-pkgs ps-pkgs-ns purs;

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
  { name = "purs-tidy";
    auto-flags = false;
  }
