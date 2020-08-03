cat <<END
name: hsdepth
version: 0.1
id: hsdepth-0.1
key: hsdepth-0.1
license: BSD3
exposed: True
exposed-modules: HsDepTH
hidden-modules:
trusted: False
import-dirs: $(pwd)/hsdepth
library-dirs: $(pwd)/hsdepth
hs-libraries: HShsdepth-0.1
extra-libraries:
extra-ghci-libraries:
include-dirs:
includes:
depends: base-4.13.0.0
cc-options:
ld-options:
framework-dirs:
frameworks:
haddock-interfaces:
END
