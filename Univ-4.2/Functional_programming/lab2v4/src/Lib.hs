module Lib
    ( integral
    , integral'
    , integral''
    , integralST
    , ceilDiv
    ) where

import Control.Parallel
import Control.Parallel.Strategies
import GHC.Conc (numCapabilities)
import Data.List.Split (chunksOf)
import Math.NumberTheory.Logarithms (intLog2)

type Func = Double -> Double
type Interval = (Double,Double)

trapezoidal :: Func -> Double -> Double -> Double
trapezoidal f x y = (f x + f y)/2 * (y-x)

rectangular :: Func -> Double -> Double -> Double
rectangular f x y = (f ((x+y)/2)) * (y-x)

simpson :: Func -> Double -> Double -> Double
simpson f x y = ((y-x)/6) * ( (f x) + 4 * f ((x+y)/2) + (f y))

integrationFunction = trapezoidal

ceilDiv a b = ceiling (fromIntegral a / fromIntegral b)

-------------------------------MULTITHREADED-----------------------------------

integrate :: Func -> [Double] -> Double
integrate f (x:[]) = 0
integrate f (x:y:xs) = left `par` right `pseq` (left + right)
                      where left = integrationFunction f x y
                            right = integrate f (y:xs)

precision_integrate :: Func -> Interval -> Double -> Double -> Double -> Double
precision_integrate f (a,b) eps delta previous_result =
            if abs (new_result-previous_result) > eps
                then precision_integrate f (a,b) eps (delta/2) new_result
                else new_result
            where new_result = integrate f [a, a+delta..b]

integral :: Func -> Interval -> Double -> Double
integral f (a,b) eps = precision_integrate f (a,b) eps (init_delta/2) (integrate f [a, a+init_delta..b])
                    where init_delta = (b-a)/3

-------------------------------MULTITHREADED2-----------------------------------

integrate' :: Func -> [Double] -> Double -> Double
integrate' _ [] _ = 0
integrate' f (x:[]) delta = integrationFunction f x (x+delta)
integrate' f list delta = sum (parMap rseq (integrateST f) sublists)    -- rseq or rpar
                      where sublists = chunksOf (((length list) `ceilDiv` (numCapabilities `ceilDiv` 2))) list

precision_integrate' :: Func -> Interval -> Double -> Double -> Double -> Double
precision_integrate' f (a,b) eps delta previous_result =
            if abs (new_result-previous_result) > eps
                then precision_integrate' f (a,b) eps (delta/2) new_result
                else new_result
            where new_result = integrate' f [a, a+delta..b] delta

integral' :: Func -> Interval -> Double -> Double
integral' f (a,b) eps = precision_integrate' f (a,b) eps (init_delta/2) (integrate' f [a, a+init_delta..b] init_delta)
                    where init_delta = (b-a)/3

-------------------------------MULTITHREADED3-----------------------------------

integrateST'' :: Func -> [Double] -> Double -> Double
integrateST'' _ [] _ = 0
integrateST'' f (x:xs) delta = left + right
                      where left = integrationFunction f x (x+delta)
                            right = integrateST'' f xs delta

integrate'' :: Func -> [Double] -> Double -> Int -> Double
integrate'' _ [] _ _ = 0
integrate'' f list delta depth = if (depth < intLog2 numCapabilities)
                                    then left `par` right `pseq` (left + right)
                                    else integrateST'' f list delta
                                               where left  = integrate'' f (head sublists) delta (depth+1)
                                                     right = integrate'' f (last sublists) delta (depth+1)
                                                     sublists = chunksOf (((length list) `ceilDiv` 2)) list

precision_integrate'' :: Func -> Interval -> Double -> Double -> Double -> Double
precision_integrate'' f (a,b) eps delta previous_result =
            if abs (new_result-previous_result) > eps
                then precision_integrate'' f (a,b) eps (delta/2) new_result
                else new_result
            where new_result = integrate'' f [a, a+delta..b] delta 0

integral'' :: Func -> Interval -> Double -> Double
integral'' f (a,b) eps = precision_integrate'' f (a,b) eps (init_delta/2) (integrate'' f [a, a+init_delta..b] init_delta 0)
                    where init_delta = (b-a)/3

-------------------------------SINGLE THREADED---------------------------------

integrateST :: Func -> [Double] -> Double
integrateST f (x:[]) = 0
integrateST f (x:y:xs) = left + right
                      where left = integrationFunction f x y
                            right = integrateST f (y:xs)

precision_integrateST :: Func -> Interval -> Double -> Double -> Double -> Double
precision_integrateST f (a,b) eps delta previous_result =
            if abs (new_result-previous_result) > eps
                then precision_integrateST f (a,b) eps (delta/2) new_result
                else new_result
            where new_result = integrateST f [a, a+delta..b]

integralST :: Func -> Interval -> Double -> Double
integralST f (a,b) eps = precision_integrateST f (a,b) eps (init_delta/2) (integrateST f [a, a+init_delta..b])
                    where init_delta = (b-a)/3

-------------------------------------------------------------------------------
