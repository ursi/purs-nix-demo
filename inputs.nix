rec
{ pkgs =
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
      { inherit pkgs; };

  purescript-tidy =
    fetchGit
      { url = "https://github.com/natefaubion/purescript-tidy.git";
        ref = "main";
        rev = "f4723287f9ea0d355e7bbdb549b85bfd3487a549";
      };
}
