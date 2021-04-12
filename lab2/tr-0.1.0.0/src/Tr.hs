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
--import Data.String.Utils
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

insertChar :: CharSet -> CharSet -> Char -> Char 
insertChar (inChar:inset) (outChar:outset) x =
    if | x == inChar -> outChar
       | otherwise -> insertChar inset outset x     

replace :: CharSet -> CharSet -> String -> String 
replace inset outset xs = reverse $ replaceAssist inset outset xs [] 
    where 
        replaceAssist _ _ [] acc = acc 
        replaceAssist inset outset (x:xs) acc = 
            if x `elem` inset then 
                if length outset == length inset then replaceAssist inset outset xs (insertChar inset outset x : acc) 
                else replaceAssist inset outset xs (head outset : acc) 
            else replaceAssist inset outset xs (x : acc)

removeChar :: CharSet -> String -> String
removeChar inset  xs = [ x | x <- xs, not (x `elem` inset) ]

tr :: CharSet -> Maybe CharSet -> String -> String
tr [] (Just []) xs = xs
tr _inset _outset xs = 
    case _outset of
        Just outset -> replace _inset outset xs
        Nothing -> removeChar _inset xs 

