{-# LANGUAGE LambdaCase, FlexibleContexts, GADTs #-}
import Data.List
import Diagrams.TwoD.Layout.Tree
import Diagrams.Backend.Rasterific.CmdLine
import Diagrams.Prelude

type Compare = (String, String)
type Return = [String]

cmp = BNode . Right
ret = leaf . Left

sort3 =
  cmp ("a", "b")
    ( cmp ("b", "c")
      ( ret ["a", "b", "c"] )
      ( cmp ("a", "c")
        ( ret ["a", "c", "b"] )
        ( ret ["c", "a", "b"] ) ) )
    ( cmp ("a", "c")
      ( ret ["b", "a", "c"] )
      ( cmp ("b", "c")
        ( ret ["b", "c", "a"] )
        ( ret ["c", "b", "a"] ) )  )

Just t = uniqueXLayout 2.5 2.5 sort3

mybox width height a = a <> (roundedRect width height 0.3 # fc white)

myellipse x y a = a <> (ellipseXY x y # fc white)

text' x = text x # font "Inconsolata" # fontSize (local 0.7)

example = pad 1.1 . centerXY
  $ renderTree
      (\case
        Left xs -> mybox 4 1.5 $ text' (unwords xs)
        Right (x, y) -> myellipse 2.30 0.75 $ text' (x ++ " ? " ++ y))
      (~~)
      t

main = mainWith (example :: Diagram B)
