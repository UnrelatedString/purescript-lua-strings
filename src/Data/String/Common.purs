module Data.String.Common
  ( null
  , localeCompare
  , replace
  , replaceAll
  , split
  , toLower
  , toUpper
  , trim
  , joinWith
  ) where

import Prelude

import Control.Monad.ST (ST)
import Data.String.Pattern (Pattern, Replacement)
import Data.Function.Uncurried (Fn5, runFn5)
import Data.Array.ST as STAr
import Data.Maybe (Maybe(..))

-- | Returns `true` if the given string is empty.
-- |
-- | ```purescript
-- | null "" == true
-- | null "Hi" == false
-- | ```
null :: String -> Boolean
null s = s == ""

-- | Compare two strings in a locale-aware fashion. This is in contrast to
-- | the `Ord` instance on `String` which treats strings as arrays of code
-- | units:
-- |
-- | ```purescript
-- | "ä" `localeCompare` "b" == LT
-- | "ä" `compare` "b" == GT
-- | ```
localeCompare :: String -> String -> Ordering
localeCompare = _localeCompare LT EQ GT

foreign import _localeCompare
  :: Ordering
  -> Ordering
  -> Ordering
  -> String
  -> String
  -> Ordering

-- | Replaces the first occurence of the pattern with the replacement string.
-- |
-- | ```purescript
-- | replace (Pattern "<=") (Replacement "≤") "a <= b <= c" == "a ≤ b <= c"
-- | ```
foreign import replace :: Pattern -> Replacement -> String -> String

-- | Replaces all occurences of the pattern with the replacement string.
-- |
-- | ```purescript
-- | replaceAll (Pattern "<=") (Replacement "≤") "a <= b <= c" == "a ≤ b ≤ c"
-- | ```
foreign import replaceAll :: Pattern -> Replacement -> String -> String

foreign import findSubstringFrom :: Fn5 Pattern String Int (Int -> Maybe Int) (Maybe Int) Maybe Int

foreign import grabSubstringIGuess :: Fn3 String Int Int String

-- | Returns the substrings of the second string separated along occurences
-- | of the first string.
-- |
-- | ```purescript
-- | split (Pattern " ") "hello world" == ["hello", "world"]
-- | ```
split :: Pattern -> String -> Array String
split sep str = STAr.run $ split' STAr.new 1
  where split' :: forall h. STAr.STArray h String -> Int -> ST h (STAr.STArray h String)
        split' a i
          | Just at <- runFn5 findSubstringFrom sep str i Just Nothing =
            do
              let 
              STAr.push chunk a
              split' a i'
          | otherwise = a

-- | Returns the argument converted to lowercase.
-- |
-- | ```purescript
-- | toLower "hElLo" == "hello"
-- | ```
foreign import toLower :: String -> String

-- | Returns the argument converted to uppercase.
-- |
-- | ```purescript
-- | toUpper "Hello" == "HELLO"
-- | ```
foreign import toUpper :: String -> String

-- | Removes whitespace from the beginning and end of a string, including
-- | [whitespace characters](http://www.ecma-international.org/ecma-262/5.1/#sec-7.2)
-- | and [line terminators](http://www.ecma-international.org/ecma-262/5.1/#sec-7.3).
-- |
-- | ```purescript
-- | trim "   Hello  \n World\n\t    " == "Hello  \n World"
-- | ```
foreign import trim :: String -> String

-- | Joins the strings in the array together, inserting the first argument
-- | as separator between them.
-- |
-- | ```purescript
-- | joinWith ", " ["apple", "banana", "orange"] == "apple, banana, orange"
-- | ```
foreign import joinWith :: String -> Array String -> String
