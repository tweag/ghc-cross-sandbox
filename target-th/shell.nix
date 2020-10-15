let crossPkgs = pkgs.pkgsCross.aarch64-multiplatform;
    haskellNix = import (builtins.fetchTarball https://github.com/input-output-hk/haskell.nix/archive/b406bb1d5bed581f651ae18a5d3ed07f47ace2b9.tar.gz) {};
    pkgs = import haskellNix.sources.nixpkgs haskellNix.nixpkgsArgs;
	iserv-proxy = pkgs.buildPackages.ghc-extra-packages.ghc8102.iserv-proxy.components.exes.iserv-proxy;
	remote-iserv = crossPkgs.ghc-extra-packages.ghc8102.remote-iserv.components.exes.remote-iserv;
	qemu = pkgs.buildPackages.qemu;
    qemuIservWrapper = pkgs.writeScriptBin "iserv-wrapper" ''
      #!${pkgs.stdenv.shell}
      set -euo pipefail
      # Unset configure flags as configure should have run already
      unset configureFlags
      PORT=$((5000 + $RANDOM % 5000))
      (>&2 echo "---> Starting remote-iserv on port $PORT")
      ${qemu}/bin/qemu-aarch64 ${remote-iserv}/bin/remote-iserv tmp $PORT &
      (>&2 echo "---| remote-iserv should have started on $PORT")
      RISERV_PID="$!"
      ${iserv-proxy}/bin/iserv-proxy $@ 127.0.0.1 "$PORT"
      (>&2 echo "---> killing remote-iserve...")
      kill $RISERV_PID
      '';

in
pkgs.mkShell {
  buildInputs =
    [ remote-iserv
	  iserv-proxy
	  crossPkgs.buildPackages.haskell-nix.compiler.ghc8102
	  qemuIservWrapper
	  qemu
	];
}
