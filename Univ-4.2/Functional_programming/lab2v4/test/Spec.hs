-- import           Test.HUnit.Base
import           Test.Tasty               (defaultMain, testGroup)
import           Test.Tasty.HUnit         (assertEqual, assertFailure, testCase, Assertion)

import           Lib
import Control.Monad (unless)

assertEquals :: String -> Double -> Double -> Double -> Assertion
assertEquals preface delta expected actual =
    unless (abs (expected - actual) < delta) (assertFailure msg)
    where msg = (if null preface then "" else preface ++ "\n") ++
                  "expected: " ++ show expected ++ " \x00B1 " ++ show delta ++ "\n but got: " ++ show actual

main = defaultMain allTests

allTests = testGroup "Integration tests" [integrationST_tests
                                        , integrationMTflood_tests
                                        , integrationMTparmap_tests
                                        , integrationMTdivide_tests]

precision_tests f = do
    assertEquals "I (1..10) 1/x"    0.01    (log 10) (f (\x -> 1/x) (1, 10) 0.01)
    assertEquals "I (1..9) x"       0.001   40       (f (\x -> x) (1, 9) 0.001)
    assertEquals "I (0..6) x^2"     0.001   72       (f (\x -> x**2) (0, 6) 0.001)

integrationST_tests =
  testCase "Single-threaded integration precision test" $ do
    precision_tests integralST

integrationMTflood_tests =
  testCase "Flood-threaded integration precision test" $ do
    precision_tests integral

integrationMTparmap_tests =
  testCase "Parmap-threaded integration precision test" $ do
    precision_tests integral'

integrationMTdivide_tests =
  testCase "Divide-threaded integration precision test" $ do
    precision_tests integral''


