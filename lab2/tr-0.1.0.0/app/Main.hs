-- | Run Haskell tr implementation.
--
-- We will be testing using your `Tr` module, not `Main`, so don't worry too
-- much about compatibility of argument parsing.

{-# LANGUAGE MultiWayIf #-} 
module Main where

import Tr

-- | Main - parse args, and read from stdin.
main :: IO ()
main = putStrLn $ tr "rk" (Just "ll") "work"