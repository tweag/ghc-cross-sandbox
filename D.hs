{-# LANGUAGE TemplateHaskell #-}
module D where

import C
import qualified Language.Haskell.TH as TH

thC :: String
thC = $(TH.runIO cprint >> [| "thC" |])
