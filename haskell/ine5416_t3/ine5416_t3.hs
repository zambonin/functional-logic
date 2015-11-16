import Data.Char
import System.Environment
import System.IO

main :: IO ()
main = do
    args <- getArgs
    case args of
        [input] -> do
            processFiles input
        _ -> putStrLn "Usage: ./ine5416_t3 input.bmp"

splitRGB (b:g:r:[]) = ([b], [g], [r])
splitRGB (b:g:[]) = ([b], [g], [0])
splitRGB (b:[]) = ([b], [0], [0])
splitRGB (b:g:r:resto) = let
    (bs, gs, rs) = splitRGB resto in (b:bs, g:gs, r:rs)

fpoint :: Int -> Float
fpoint i = fromIntegral i / 256

toList :: (a, a, a) -> [a]
toList (x, y, z) = [x, y, z]

processFiles input = do
    inString <- readFile input
    let fname = take (length input - 4) input
    let outnames = map (fname++) ["_blue.out", "_green.out", "_red.out"]
    outputs <- sequence [openFile f WriteMode | f <- outnames]
    let depth = snd (splitAt 54 (map ord inString))
    let rgb = toList (splitRGB (map fpoint depth))
    sequence [hPrint file color | (file, color) <- zip outputs rgb]
    sequence [hClose f | f <- outputs]
    return ()
