{-# LANGUAGE TemplateHaskell #-}
module E where

import C

noTHC :: IO ()
noTHC = $([| cprint |])
