This repo shows how to do cross-compilation with GHC.

It doesn't use other build tools than `make`. The included Makefile
builds some Haskell packages with GHC.

The Makefile strives to be very precise. It runs compile and link
phases separately, specifying the dependencies for each phase.

To build run
```
nix-shell --pure --run "make -j"
```

nix will build a cross-compiler for arm64. This isn't used for
anything just yet, but it will be used soon.
