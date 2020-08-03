{-# LANGUAGE TemplateHaskell #-}
module A where

import HsDep
import qualified Language.Haskell.TH as TH


thHsDep :: String
thHsDep = $(TH.stringE ("TH" ++ hsDep))
