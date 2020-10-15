{-# LANGUAGE TemplateHaskell #-}

import Language.Haskell.TH

main = $(do runIO (putStrLn "Hello, ")
            [| putStrLn "World!" |]
        )
