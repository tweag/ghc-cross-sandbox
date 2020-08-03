cat <<END
name: hsdep
version: 0.1
id: hsdep-0.1
key: hsdep-0.1
license: BSD3
exposed: True
exposed-modules: HsDep
hidden-modules:
trusted: False
import-dirs: $(pwd)/hsdep
library-dirs: $(pwd)/hsdep
hs-libraries: HShsdep-0.1
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
