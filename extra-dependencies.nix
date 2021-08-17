# all these pacakges are now in the purs-nix package set, however, they weren't when this demo was made, so this file kept around for fairness.
purs-nix:
  let inherit (purs-nix) build ps-pkgs; in
  { argparse-basic =
      build
        { name = "argparse-basic";
          version = "1.0.0";
          repo = "https://github.com/natefaubion/purescript-argparse-basic.git";
          rev = "cad9bd94a84ccf50c53be2f21ab5941a0a9ffeb9";

          dependencies =
            with ps-pkgs;
            [ arrays
              const
              effect
              either
              filterable
              foldable-traversable
              free
              functors
              maybe
              numbers
              strings
              transformers
              tuples
              typelevel-prelude
            ];
        };

    node-glob-basic =
      build
        { name = "node-glob-basic";
          version = "1.2.0";
          repo = "https://github.com/natefaubion/purescript-node-glob-basic.git";
          rev = "22b374b30537a945310fb8049f5bce1b51a7a669";

          dependencies =
            with ps-pkgs;
            [ aff
              console
              effect
              lists
              maybe
              node-fs-aff
              node-path
              node-process
              ordered-collections
              strings
            ];
        };

    node-workerbees =
      build
        { name = "node-workerbees";
          version = "0.1.2";
          repo = "https://github.com/natefaubion/purescript-node-workerbees.git";
          rev = "5ab52953b64f05b97e8605755708e483c3c44722";

          dependencies =
            with ps-pkgs;
            [ aff
              argonaut-core
              arraybuffer-types
              avar
              effect
              either
              exceptions
              maybe
              newtype
              parallel
              variant
            ];
        };

    purescript-language-cst-parser =
      build
        { name = "purescript-language-cst-parser";
          version = "0.9.0";
          repo = "https://github.com/natefaubion/purescript-language-cst-parser.git";
          rev = "0b2410c25f638dcf00089c206d9e4af65f5845d0";

          dependencies =
            with ps-pkgs;
            [ arrays
              const
              effect
              either
              foldable-traversable
              free
              functors
              maybe
              numbers
              ordered-collections
              strings
              transformers
              tuples
              typelevel-prelude
            ];
        };
  }
