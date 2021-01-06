This repository is an experiment on cross-compiling with GHC.

## Running splices in the target platform

The folder target-th contains a nix file to run splices
in the target platform. It uses haskell.nix to get the
necessary tools. To build

```
cd target-th
nix-shell --pure --run "aarch64-unknown-linux-gnu-ghc -pgmi iserv-wrapper -fexternal-interpreter Main.hs"
```
and to run the result
```
cd target-th
nix-shell --pure --run "qemu-aarch64 ./Main"
```
## Running splices in the build platform

The included Makefile builds some Haskell packages with GHC natively.

Makefile.aarch64 builds the same project for aarch64. It uses the
cross GHC provided by nix together with a native iserv to run TH
splices in the build platform.

The makefiles strive to be very precise. They run compile and link
phases separately, specifying the dependencies for each phase.

To build a native executable run
```
nix-shell --pure --run "make -j"
```
This builds an executable `a.out` that prints some text to the console.

To build an aarch64 executable run
```
nix-shell --pure --run "make -f Makefile.aarch64 -j"
```
The resulting executable `a-cross.out` can be executed with
```
nix-shell --pure --run "qemu-aarch64 a-cross.out"
```
