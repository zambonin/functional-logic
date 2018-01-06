-- INE5416 - Paradigmas de Programação (2015/2)
-- Gustavo Zambonin (13104307)

module Summation (oddIntegersSeries, sumOddIntegers, evenIntegersSeries,
                  sumEvenIntegers, squaresSeries, sumSquares, oddSquaresSeries,
                  sumOddSquares, almostTwo, almostEuler) where

oddIntegersSeries n = [x*((2*x-1) + 1)/2 | x <- [1..n]]
sumOddIntegers n = last(oddIntegersSeries n)

evenIntegersSeries n = [x*(2*x + 2)/2 | x <- [1..n]]
sumEvenIntegers n = last(evenIntegersSeries n)

squaresSeries n = [x*(x+1)*(2*x+1)/6 | x <- [1..n]]
sumSquares n = last(squaresSeries n)

oddSquaresSeries n = [x*(4*x^2-1)/3 | x <- [1..n]]
sumOddSquares n = last(oddSquaresSeries n)

almostTwo n = sum([2/(x+x^2) | x <- take n [1..]])
almostEuler n = 1 + sum([1 / product[1..x] | x <- take n [1..]])
