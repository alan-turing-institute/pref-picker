module Main exposing (main, update, view)

import Browser
import Html exposing (Html, h1, button, div, text)
import Html.Events exposing (onClick)

import File.Download 

import List exposing (length, map)
import Tuple exposing (first, second)

import Random exposing (generate)
import Random.List


{-- Option set. There must be at least two options --}

theOptions = ["apple", "banana", "orange", "grape", "strawberry",
                  "mango", "pineapple", "kiwi", "blueberry", "pear", "peach",
                  "cherry", "plum", "watermelon", "papaya", "raspberry",
                  "blackberry", "coconut", "pomegranate", "apricot"]
             
-- Helper function to make a pair of the first two elements of a list,
-- with defaults if there aren't at least two elements in the list
getChoices : List String -> (String, String)
getChoices xs =
    case xs of
        fst :: snd :: _ -> (fst, snd)
        _               -> ("INSUFFICIENT", "OPTIONS")
                                              
{-- Utility functions --}
    
swap : (a, b) -> (b, a)
swap (x, y) = (y, x)

              
chosenToString : List (String, String) -> String
chosenToString xs =
    let
        pairToString p =
            "(" ++ Tuple.first p ++ ", " ++ Tuple.second p ++ ")"
        listToString ys =
            List.foldl (++) "" (List.intersperse ", " ys) 
    in
        listToString (map pairToString xs)

            
pickTwoChoices : Cmd Msg
pickTwoChoices =
    Random.generate 
        (\xs -> NewChoices (getChoices (first xs)))
        (Random.List.choices 2 theOptions)

save : List (String, String) -> Cmd Msg
save cs =
    File.Download.string "chosen.txt" "text/plain" (chosenToString cs) 
            
            
{-- App --}
              
type alias Model =
    {choices : (String, String),       --- Current presented options
     chosen  : List (String, String)   --- Previous user choices 
    }

type Msg = Left | Right | NewChoices (String, String) | Save


main =
    Browser.element { init = init,
                      update = update,
                      subscriptions = subscriptions,
                      view = view
                    }

        
init : () -> (Model, Cmd Msg)
init _ =
    ( { choices = ("",""), chosen = [] }, pickTwoChoices )

         
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
         Left ->  ({ model | chosen = model.choices :: model.chosen }, pickTwoChoices )
         Right -> ({ model | chosen = (swap model.choices) :: model.chosen }, pickTwoChoices )
         NewChoices cs -> ({ model | choices = cs }, Cmd.none)
         Save -> (model, save model.chosen)
        
subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Html Msg
view model =
    let {choices, chosen} = model in
    div [] [
         h1 [] [ text "Left or right?" ],
         button [ onClick Left ] [ text (first choices) ],
         text " ",
         button [ onClick Right ] [ text (second choices) ],
         div [] [ text (chosenToString chosen) ],
         button [ onClick Save ] [ text "Save" ]
        ]

            
