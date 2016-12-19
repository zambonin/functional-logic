x // y = do
    a <- x
    b <- y
    if b == 0
        then Nothing
        else Just (a/b)

soma x y = do
    a <- x
    b <- y
    return (a+b)

total x y = let
    one = return 1
    r1 = return x
    r2 = return y
    in one // (soma (one // r1) (one // r2))
