{-# LANGUAGE MultiWayIf #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Risk where

import Control.Monad.Random
import Control.Monad
import Data.List

------------------------------------------------------------

newtype DieValue = DV { unDV :: Int } 
  deriving (Eq, Ord, Show, Num)

getValueFromRand :: (a -> b) -> (a, c) -> (b, c)
getValueFromRand f (a, c) = (f a, c)

instance Random DieValue where
  random           = getValueFromRand DV . randomR (1,6)
  randomR (low,hi) = getValueFromRand DV . randomR (max 1 (unDV low), min 6 (unDV hi))

die :: Rand StdGen DieValue
die = getRandom

------------------------------------------------------------

type Army = Int
data Battlefield = Battlefield { attackers  
                               , defenders :: Army }
  deriving (Show)

dieAny :: Int -> Rand StdGen [DieValue]
dieAny 0 = return []
dieAny n = do
  x <- die
  xs <- dieAny (n - 1)
  return $ reverse $ sort (x:xs)
------------------------------------------------------------
-- Exercise 2 (Write a function with simulates a single battle)

battle :: Battlefield -> Rand StdGen Battlefield
battle (Battlefield attackerNum defendersNum) = 
  dieAny (min (attackerNum-1) 3) >>= \attackDies ->
  dieAny (min defendersNum 2) >>= \defendDies ->
  return $ fight attackerNum defendersNum attackDies defendDies
  where 
    fight att def [] _  = Battlefield att def
    fight att def _ []  = Battlefield att def
    fight att def (x:xs) (y:ys) 
      | x > y       = fight att (def-1) xs ys
      | otherwise   = fight (att-1) def xs ys 


------------------------------------------------------------
-- Exercise 3 (Implement a function which simulates an entire invasion attempt)

invasion :: Battlefield -> Rand StdGen Battlefield
invasion (Battlefield attackUnitNum defUnitNum)  =
    if | attackUnitNum >= 2 && defUnitNum /= 0 -> battle (Battlefield attackUnitNum defUnitNum) >>= \x-> invasion x
       | otherwise                             -> return $ Battlefield attackUnitNum defUnitNum

------------------------------------------------------------
-- Exercise 4 (Implement a function which compute the estimated probability that
-- the attacking army will completely destroy the defending army)

successProb :: Battlefield -> Rand StdGen Double
successProb (Battlefield attackersNumber defendersNumber) = do 
  battles <- replicateM 1000 (invasion $Battlefield attackersNumber defendersNumber)
  return $ sum [1 | x <- battles, defenders x == 0] / 1000 

------------------------------------------------------------

demonstrateGame :: IO ()
demonstrateGame = do
  values <- evalRandIO $ invasion (Battlefield 7 10)
  prob <- evalRandIO $ successProb (Battlefield 7 10)
  print values
  print prob