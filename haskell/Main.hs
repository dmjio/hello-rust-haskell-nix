module Main where

import Foreign.C.String

foreign import ccall unsafe "hello_rust" hello_rust :: IO CString

main :: IO ()
main = putStrLn =<< peekCString =<< hello_rust
