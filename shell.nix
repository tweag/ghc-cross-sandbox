let pkgs = import ./nixpkgs.nix {};
    crossPkgs = pkgs.pkgsCross.aarch64-multiplatform;
in
pkgs.mkShell {
  buildInputs = [
      # crossPkgs.haskell.compiler.ghc883
      crossPkgs.haskellPackages.ghc
	  pkgs.haskell.compiler.ghc883
	  pkgs.qemu
    ];
}
