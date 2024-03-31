{ name = "purescript-lua-strings"
, dependencies =
  [ "arrays"
  , "enums"
  , "foldable-traversable"
  , "gen"
  , "integers"
  , "maybe"
  , "newtype"
  , "nonempty"
  , "partial"
  , "prelude"
  , "tailrec"
  , "tuples"
  , "unfoldable"
  , "unsafe-coerce"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
