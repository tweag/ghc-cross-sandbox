{-# LANGUAGE TemplateHaskell #-}
module Main where

import A
import B
import D
import E
import F
import G
import HsDepTH
import qualified Language.Haskell.TH as TH


main = do
  putStrLn noTH
  putStrLn thHsDep
  cprint
  putStrLn thC
  noTHC
  putStrLn noTHHsDep
  putStrLn $(TH.stringE thOnly)
  putStrLn $(TH.stringE hsDepTH)
