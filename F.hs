{-# LANGUAGE TemplateHaskell #-}
module F where

import HsDep


noTHHsDep :: String
noTHHsDep = $([| hsDep |])
