-- INE5416 - Paradigmas de Programação (2015/2)
-- Gustavo Zambonin (13104307)

module Shapes (Shape (Sphere, Cylinder, Cone, Frustum, OblateSpheroid,
                      ProlateSpheroid),
               Radius, Height, BaseRadius, UpperBaseRadius, BiggerSemiAxis,
               SmallerSemiAxis) where

data Shape = Sphere Radius
           | Cylinder BaseRadius Height
           | Cone BaseRadius Height
           | Frustum BaseRadius UpperBaseRadius Height
           | OblateSpheroid BiggerSemiAxis SmallerSemiAxis
           | ProlateSpheroid BiggerSemiAxis SmallerSemiAxis
     deriving Show

type Radius = Float
type Height = Float
type BaseRadius = Float
type UpperBaseRadius = Float
type BiggerSemiAxis = Float
type SmallerSemiAxis = Float

ecc :: BiggerSemiAxis -> SmallerSemiAxis -> Float
ecc a b = (sqrt(a^2 - b^2))/a

area :: Shape -> Float
area (Sphere r) = 4*pi*r^2
area (Cylinder r h) = 2*pi*r*(r+h)
area (Cone r h) = pi*r*(sqrt(r^2 + h^2) + r)
area (Frustum r1 r2 h) = pi*(r1^2 + r2^2 + (r1+r2)*sqrt(h^2 + (r1 - r2)^2))
area (OblateSpheroid a b) = 2*pi*a^2 + ((b^2)/(ecc a b))*log((1 + ecc a b)/
                                                             (1 - ecc a b))
area (ProlateSpheroid a b) = 2*pi*(b^2 + ((a*b)/(ecc a b))*(asin(ecc a b)))

volume :: Shape -> Float
volume (Sphere r) = (4/3)*pi*r^3
volume (Cylinder r h) = pi*h*r^2
volume (Cone r h) = (1/3)*pi*h*r^2
volume (Frustum r1 r2 h) = (1/3)*pi*h*(r1^2 + r2^2 + r1*r2)
volume (OblateSpheroid a b) = (4/3)*pi*b*a^2
volume (ProlateSpheroid a b) = (4/3)*pi*a*b^2
