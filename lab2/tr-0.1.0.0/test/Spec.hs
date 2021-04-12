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

    describe "inset > outset" $
      it "abcdef -> dddddf" $
        tr' "abcde" "d" "abcdef" `shouldBe` "dddddf"
    
    describe "inset < outset" $
      it "atfa -> btfb" $
        tr' "a" "bbb" "atfa" `shouldBe` "btfb"


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

    describe "border test1" $
      it "work -> work" $
        tr' "" "ll" "work" `shouldBe` "work"

    describe "border test2" $
      it "border -> border" $
        tr' "ll" "" "border" `shouldBe` "border"

    describe "border test3" $
      it " -> " $
        tr' "ll" "kk" "" `shouldBe` ""

    describe "border test4" $
      it "attr->attr" $
        tr' "" "" "attr" `shouldBe` "attr"

    describe "delete check3" $
      it "work -> wok" $
        trDeleting "r" "work" `shouldBe` "wok" 

    describe "delete check4" $
      it "1heytime -> heyme" $
        trDeleting "1ti" "1heytime" `shouldBe` "heyme" 
    
    describe "delete check border" $
      it "work -> work" $
        trDeleting "" "work" `shouldBe` "work" 
    
    describe "delete check border" $
      it "work -> " $
        trDeleting "work" "" `shouldBe` "" 
    
    describe "delete check border" $
      it "work -> " $
        trDeleting "" "" `shouldBe` "" 

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

