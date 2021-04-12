module Main (main) where

import Test.Hspec
import Test.QuickCheck
import Control.Monad.Random
import Control.Monad
import Data.List
import System.IO.Unsafe

import Risk

main :: IO ()
main = hspec $ describe "Test scope" $ do
    describe "Test 1" $
      it "Army decrease" $
        property $ do
          let a = 10
              d = 10
          checkDecrease (a, d) (returnVal $ battle (Battlefield a d))

    describe "Test 2" $
      it "Army destroyed" $ 
        property $ checkDestroyed $ returnVal $ invasion (Battlefield 10 10)

    describe "Probablity edge testing1" $
      it "1 probability without defenders" $
        returnVal (successProb (Battlefield 10 0)) `shouldBe` (1.0 :: Double)
  
    describe "Probablity edge testing2" $
      it "0 probability without attackers" $
         returnVal (successProb (Battlefield 0 10)) `shouldBe` (0.0 :: Double)

    describe "Test 3" $
      it "from 0 to 1" $
        property $ prop_range (returnVal (successProb (Battlefield 10 10)))

-- prop_ex :: Battlefield -> Rand StdGen Double
returnVal = unsafePerformIO . evalRandIO

prop_range :: Double -> Bool 
prop_range val = val > 0.0 && val < 1.0

checkDecrease :: (Army, Army) -> Battlefield -> Bool
checkDecrease (a, d) bf = attackers bf < a || defenders bf < d

checkDestroyed :: Battlefield -> Bool
checkDestroyed bf = attackers bf == 1 || defenders bf == 0