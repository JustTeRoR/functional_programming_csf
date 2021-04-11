-- | Haskell tr implementation. Just supports the swap and delete modes:
-- * tr string1 string2
-- * tr -d string1
--
-- PLEASE DON'T CHANGE THE INTERFACE OF THIS FILE AS WE WILL EXPECT IT TO BE
-- THE SAME WHEN TESTING!
{-# LANGUAGE MultiWayIf #-}

module Tr
    ( CharSet
    , tr
    ) where

-- | Just to give `tr` a more descriptive type
type CharSet = String

-- | 'tr' - the characters in the first argument are translated into characters
-- in the second argument, where first character in the first CharSet is mapped
-- to the first character in the second CharSet. If the first CharSet is longer
-- than the second CharSet, the last character found in the second CharSet is
-- duplicated until it matches in length.
--
-- If the second CharSet is a `Nothing` value, then 'tr' should run in delete
-- mode where any characters in the input string that match in the first
-- CharSet should be removed.
--
-- The third argument is the string to be translated (i.e., STDIN) and the
-- return type is the output / translated-string (i.e., STDOUT).
-- 
-- translate mode: tr "eo" (Just "oe") "hello" -> "holle"
-- delete mode: tr "e" Nothing "hello" -> "hllo"
--
-- It's up to you how to handle the first argument being the empty string, or
-- the second argument being `Just ""`, we will not be testing this edge case.
equivalentElement :: Char -> CharSet -> Bool
equivalentElement el [] = False
equivalentElement el (x:xs) =
    if | el == x -> True
       | otherwise -> equivalentElement el xs

insertChar :: CharSet -> CharSet -> Char -> Char 
insertChar (inChar:inset) (outChar:outset) x =
    if | x == inChar -> outChar
       | otherwise -> insertChar inset outset x     

replace :: CharSet -> CharSet -> String -> String
replace _ _ [] = []
replace inset outset (x:xs) = 
    if | x `equivalentElement` inset  ->
        if  | length outset == length inset -> insertChar inset outset x : replace inset outset xs
            | otherwise ->  head outset : replace inset outset xs
       | otherwise -> x : replace inset outset xs

delete :: CharSet -> String -> String
delete _ [] = []
delete inset (x:xs) = 
    if | x `equivalentElement` inset -> delete inset xs
       | otherwise -> x : delete inset xs

tr :: CharSet -> Maybe CharSet -> String -> String
tr [] (Just []) xs = xs
tr _inset _outset xs = 
    case _outset of
        Just outset -> replace _inset outset xs
        Nothing -> delete _inset xs 

