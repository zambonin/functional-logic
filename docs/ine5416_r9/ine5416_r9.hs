diff n = n!!1 - head(n)
e = 1 + sum([1 / product[1..x] | x <- take 1000 [1..]])
gamma n = sqrt(2*pi / n) * (1/e * (n + (1/(12*n - 1/(10*n))))) ** n

sumAP n = (length n) * (2 * head(n) + (length n - 1) * diff n) `div` 2
productAP n = (diff n ** fromIntegral (length n)) *
    (gamma ((head(n) / diff n) + fromIntegral (length n)) /
     gamma (head(n) / diff n))
