-- INE5416 - Paradigmas de Programação (2015/2)
-- Gustavo Zambonin (13104307)

module Shapes (Shape (Spheroid, Cylinder, Cone, Frustum), EquatorialRadius,
               PolarRadius, Height, BaseRadius, UpperBaseRadius) where

data Shape = Spheroid EquatorialRadius PolarRadius
           | Cylinder BaseRadius Height
           | Cone BaseRadius Height
           | Frustum BaseRadius UpperBaseRadius Height
     deriving Show

type EquatorialRadius = Float
type PolarRadius = Float
type Height = Float
type BaseRadius = Float
type UpperBaseRadius = Float

ecc :: EquatorialRadius -> PolarRadius -> Float
ecc a c
    | c < a = sqrt((a^2 - c^2)/(a^2)) -- ellipse of oblate  (a = b > c)
    | c > a = sqrt((c^2 - a^2)/(c^2)) -- ellipse of prolate (a = b < c)
    | c == a = 0                      -- circle of sphere   (a = b = c)

area :: Shape -> Float
area (Spheroid a c)
    | c < a = 2*pi*a^2 + ((pi*c^2)/(ecc a c))*log((1 + ecc a c)/(1 - ecc a c))
    | c > a = 2*pi*(a^2 + ((a*c)/(ecc a c))*(asin(ecc a c)))
    | c == a = 4*pi*c^2
area (Cylinder r h) = 2*pi*r*(r+h)
area (Cone r h) = pi*r*(sqrt(r^2 + h^2) + r)
area (Frustum r1 r2 h) = pi*(r1^2 + r2^2 + (r1+r2)*sqrt(h^2 + (r1 - r2)^2))

volume :: Shape -> Float
volume (Spheroid a c) = (4/3)*pi*c*a^2
volume (Cylinder r h) = pi*h*r^2
volume (Cone r h) = (1/3)*pi*h*r^2
volume (Frustum r1 r2 h) = (1/3)*pi*h*(r1^2 + r2^2 + r1*r2)
