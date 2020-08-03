

a.out: Main.o A.o B.o C.o D.o E.o F.o cdep.o hsdep/libHShsdep-0.1.a
	ghc Main.o A.o B.o C.o D.o E.o F.o cdep.o hsdep/libHShsdep-0.1.a

Main.o Main.hi: A.hi B.hi D.hi E.hi F.hi G.dyn_o Main.hs hsdepth/pkgdb hsdepth/HsDepTH.hi hsdepth/libHShsdepth-0.1-ghc8.8.3.so
	ghc -c Main.hs hsdepth/libHShsdepth-0.1-ghc8.8.3.so -package-db hsdepth/pkgdb

# We need both the .hi and the shared library when using the dependency in TH.
A.o A.hi: hsdep/HsDep.hi hsdep/libHShsdep-0.1-ghc8.8.3.so A.hs hsdep/pkgdb
	ghc -c A.hs -package-db hsdep/pkgdb

# When not using the dependency for running TH splices,
# we don't need the shared library to compile.
B.o B.hi: hsdep/HsDep.hi B.hs C.hi hsdep/pkgdb
	ghc -c B.hs -package-db hsdep/pkgdb

# We don't need to pass cdep.o when building a module that
# refers to it.
C.o C.hi: C.hs
	ghc -c C.hs -dynamic-too

# We need to pass cdep.o when building so ghc can load
# it for running TH splices.
D.o D.hi: D.hs C.hi cdep.o
	ghc -c D.hs cdep.o

# We don't need cdep.o if TH splices don't need it
E.o E.hi: E.hs C.hi
	ghc -c E.hs

# We only need the interface file if TH doesn't use the dependency
F.o F.hi: hsdep/HsDep.hi F.hs hsdep/pkgdb
	ghc -c F.hs -package-db hsdep/pkgdb

# G is needed for compiling Main, but not for linking it.
G.o G.hi G.dyn_o G.dyn_hi: G.hs
	ghc -c G.hs -dynamic-too

cdep.o: cdep.c
	gcc -c cdep.c


# haskell dependencies

hsdep/pkgdb:
	mkdir hsdep/pkgdb
	./cat-hsdep-info.sh > hsdep/pkgdb/hsdep-0.1.conf
	ghc-pkg recache --package-db hsdep/pkgdb

hsdep/libHShsdep-0.1.a: hsdep/HsDep.o
	ar cqs hsdep/libHShsdep-0.1.a hsdep/HsDep.o

hsdep/libHShsdep-0.1-ghc8.8.3.so: hsdep/HsDep.dyn_o
	ghc -shared -dynamic -o hsdep/libHShsdep-0.1-ghc8.8.3.so hsdep/HsDep.dyn_o

hsdep/HsDep.dyn_hi hsdep/HsDep.dyn_o hsdep/HsDep.hi hsdep/HsDep.o:
	ghc -c -dynamic-too -this-unit-id hsdep-0.1 hsdep/HsDep.hs -dynhisuf dyn_hi -dynosuf dyn_o

hsdepth/pkgdb:
	mkdir hsdepth/pkgdb
	./cat-hsdepth-info.sh > hsdepth/pkgdb/hsdepth-0.1.conf
	ghc-pkg recache --package-db hsdepth/pkgdb

# hsdepth is needed for compiling Main, but not for linking it.
hsdepth/libHShsdepth-0.1.a: hsdepth/HsDepTH.o
	ar cqs hsdepth/libHShsdepth-0.1.a hsdepth/HsDepTH.o

hsdepth/libHShsdepth-0.1-ghc8.8.3.so: hsdepth/HsDepTH.dyn_o
	ghc -shared -dynamic -o hsdepth/libHShsdepth-0.1-ghc8.8.3.so hsdepth/HsDepTH.dyn_o

hsdepth/HsDepTH.dyn_hi hsdepth/HsDepTH.dyn_o hsdepth/HsDepTH.hi hsdepth/HsDepTH.o:
	ghc -c -dynamic-too -this-unit-id hsdepth-0.1 hsdepth/HsDepTH.hs -dynhisuf dyn_hi -dynosuf dyn_o


clean:
	rm -rf *.o *.hi *.so *.dyn_hi *.dyn_o a.out
	rm -rf hsdep/*.o hsdep/*.hi hsdep/*.so hsdep/*.a hsdep/*.dyn_hi hsdep/*.dyn_o hsdep/pkgdb
	rm -rf hsdepth/*.o hsdepth/*.hi hsdepth/*.so hsdepth/*.a hsdepth/*.dyn_hi hsdepth/*.dyn_o hsdepth/pkgdb
