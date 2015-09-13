module BingoUtils where
{-| This modules defines various utility functions for the Bingo app.

These functions involve fairly advanced features of Elm that we don't
delve into during the course.

It's possible that future versions of the Elm core libraries
might provide these functions.
-}

import String exposing (toInt)
import Html exposing (Attribute)
import Signal exposing (Address)
import Json.Decode as Json
import Html.Events exposing (..)


onInput : Address a -> (String -> a) -> Attribute
onInput address f =
  on "input" targetValue (\v -> Signal.message address (f v))

onEnter : Address a ->  a -> Attribute
onEnter address value =
  on "keydown"
    (Json.customDecoder keyCode is13)
    (\_ -> Signal.message address value)

is13 : Int -> Result String ()
is13 code =
  if code == 13 then Ok () else Err "not the right key code"

parseInt : String -> Int
parseInt string =
  case String.toInt string of
    Ok value ->
      value
    Err error ->
      0
