module Main where

import Lib
import GHC.Conc (numCapabilities)
import Criterion.Main

f = (\x -> 1/x)
range = (1, 90000)

integrationBenchST precision = do
    integralST f range precision

integrationBenchMTflood precision = do
    integral f range precision

integrationBenchMTparmap precision = do
    integral' f range precision

integrationBenchMTdivide precision = do
    integral'' f range precision

main = defaultMain [
      bgroup "integrateST"   [ bench "0.1"        $ whnf integrationBenchST 0.1
                             , bench "0.01"       $ whnf integrationBenchST 0.01
                             , bench "0.001"      $ whnf integrationBenchST 0.001
                             ]
  ,
  bgroup "integrateMTflood"  [ bench "0.1"       $ whnf integrationBenchMTflood 0.1
                             , bench "0.01"      $ whnf integrationBenchMTflood 0.01
                             , bench "0.001"     $ whnf integrationBenchMTflood 0.001
                             ]
  ,
  bgroup "integrateMTparmap" [ bench "0.1"      $ whnf integrationBenchMTparmap 0.1
                             , bench "0.01"     $ whnf integrationBenchMTparmap 0.01
                             , bench "0.001"    $ whnf integrationBenchMTparmap 0.001
                             ]
  ,
  bgroup "integrateMTdivide" [ bench "0.1"      $ whnf integrationBenchMTdivide 0.1
                             , bench "0.01"     $ whnf integrationBenchMTdivide 0.01
                             , bench "0.001"    $ whnf integrationBenchMTdivide 0.001
                             ]
  ]
