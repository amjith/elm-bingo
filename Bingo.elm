module Bingo where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String exposing (toUpper, repeat, trimRight)

import StartApp

-- Model

newEntry phrase points id = 
  { phrase = phrase,
    points = points,
    wasSpoken = False,
    id = id
  }

initialModel = 
  { entries = 
      [ newEntry "Doing Agile" 100 2,
        newEntry "Future Proof" 300 3,
        newEntry "Touch Base" 400 1,
        newEntry "In the cloud" 200 4
      ] 
  } 

-- Update

type Action 
  = NoOp 
  | Sort

update action model = 
  case action of
    NoOp -> 
      model
    Sort ->
      { model | entries <- List.sortBy .points model.entries }

-- View

title message times = 
  message ++ " "
    |> toUpper 
    |> repeat times 
    |> trimRight
    |> text


pageHeader = 
  h1 [  ] [ title "Bingo" 3 ] 


pageFooter = 
  footer [  ] 
    [ a [ href "http://blog.amjith.com" ] 
        [ text "Amjith Ramanujam" ] 
    ] 

entryItem entry =
  li [  ]
    [ span [ class "phrase" ] [ text entry.phrase ],
      span [ class "points" ] [ text (toString entry.points) ] 
    ]

entryList entries = 
  ul [  ] (List.map entryItem entries) 

view address model = 
  div [ id "container" ] 
    [ pageHeader, 
      entryList model.entries,
      button 
        [ class "sort", onClick address Sort ] 
        [ text "sort" ],
      pageFooter 
    ]

-- Wire it all together

main = 
  -- view (update Sort initialModel)
  StartApp.start
    { model = initialModel,
      view = view,
      update = update
    }
