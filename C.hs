{-# LANGUAGE ForeignFunctionInterface #-}
module C where

foreign import ccall cprint :: IO ()
