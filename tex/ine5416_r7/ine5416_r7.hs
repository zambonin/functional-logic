module Hyperbolic (HFunction (Sinh, Cosh, Tanh, Coth), e) where

data HFunction = Sinh Float
               | Cosh Float
               | Tanh Float
               | Coth Float
     deriving Show

e = 1 + sum([1 / product[1..x] | x <- take 1000 [1..]])

value :: HFunction -> Float
value (Sinh x) = (1 - e**(-2*x))/(2*e**(-x))
value (Cosh x) = (1 + e**(-2*x))/(2*e**(-x))
value (Tanh x) = (value (Sinh x))/(value (Cosh x))
value (Coth x) = (value (Cosh x))/(value (Sinh x))
