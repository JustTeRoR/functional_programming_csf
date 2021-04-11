-- | Test Haskell tr implementation.
--
-- We provide a few very simple tests here as a demonstration. You should add
-- more of your own tests!
--
-- Run the tests with `stack test`.
module Main (main) where

import Test.Hspec
import Test.QuickCheck

import Tr

type CharSet' = NonEmptyList Char

tr' :: CharSet -> CharSet -> String -> String
tr' inset outset = tr inset (Just outset)
trDeleting inset = tr inset Nothing

-- | Test harness.
main :: IO ()
main = hspec $ describe "Testing tr" $ do
    describe "single translate" $
      it "a -> b" $
        tr' "a" "b" "a" `shouldBe` "b"

    describe "stream translate" $
      it "a -> b" $
        tr' "a" "b" "aaaa" `shouldBe` "bbbb"

    describe "extend input set" $
      it "abc -> d" $
        tr' "abc" "d" "abcd" `shouldBe` "dddd"

    describe "hello" $
      it "hello -> holle" $
        tr' "eo" "oe" "hello" `shouldBe` "holle"
    
    describe "workCheck1" $
      it "work -> woll" $
        tr' "rk" "ll" "work" `shouldBe` "woll"
        
    describe "workCheck2" $
      it "1time -> slime" $
        tr' "1ti" "sli" "1time" `shouldBe` "slime"
  
    describe "delete check1" $
      it "1time -> time" $
        trDeleting "1" "1time" `shouldBe` "time" 
    
    describe "delete check2" $
      it "work -> wo" $
        trDeleting "rk" "work" `shouldBe` "wo" 
    
    describe "delete all" $
      it "hello -> " $
        trDeleting "helo" "heeellooooo" `shouldBe` "" 

    describe "tr quick-check" $
      it "empty input is identity" $ property prop_empty_id
      
-- | An example QuickCheck test. Tests the invariant that `tr` with an empty
-- input string should produce and empty output string.
prop_empty_id :: CharSet' -> CharSet' -> Bool
prop_empty_id (NonEmpty set1) (NonEmpty set2)
  = tr' set1 set2 "" == ""

