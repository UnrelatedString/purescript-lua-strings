let upstream-ps =
      https://github.com/purescript/package-sets/releases/download/psc-0.15.15-20240320/packages.dhall
        sha256:ae8a25645e81ff979beb397a21e5d272fae7c9ebdb021a96b1b431388c8f3c34

let upstream-lua =
      https://github.com/Unisay/purescript-lua-package-sets/releases/download/psc-0.15.15-20240342/packages.dhall
        sha256:c7b900b5f26717504a50b14fdcc24796ce505801ad068c9e2496519e6042e139

in  upstream-ps // upstream-lua
