module Main exposing (..)

import Html exposing (Html, Attribute)
import Html.Attributes exposing (type_)
import Html.Events exposing (onClick, onInput, on)


-- Model
{-
   First we want to approximate the data
   that will flow through the app. We'll slowly
   build up a representation of this within our Model type.
   It will represent the shape of our data.
-}


type alias Hole =
    { holeNum : Int
    , par : Int
    }


type alias Player =
    { score : Int
    }


type alias Model =
    { currentHole : Int
    , course : List Hole
    , score : Int
    , players : List Player
    }



{-
   Let's create a simple expression that returns
   a starting value for the Model. We'll set the values
   of both attributes to zero just to start. You'll notice that we
   also have a type annotation above the init function.
   This provides a way to tell what data is flowing into
   and out of functions. You'll see that the `init` function
   simply returns a type of Model (which we created out of thin air above)
-}


course : List Hole
course =
    [ Hole 1 4
    , Hole 2 4
    , Hole 3 5
    , Hole 4 3
    , Hole 5 4
    , Hole 6 4
    , Hole 7 5
    , Hole 8 4
    , Hole 9 3
    ]


init : ( Model, Cmd Msg )
init =
    -- { currentHole = 0, score = 0 }
    ( Model 0 course 0 [], Cmd.none )



-- Update


type Msg
    = Birdie
    | Par
    | Bogey
    | UpdateScore Hole String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Birdie ->
            ( { model | currentHole = model.currentHole + 1, score = model.score - 1 }, Cmd.none )

        Par ->
            ( { model | currentHole = model.currentHole + 1 }, Cmd.none )

        Bogey ->
            ( { model | currentHole = model.currentHole + 1, score = model.score + 1 }, Cmd.none )

        UpdateScore hole score ->
            ( model, Cmd.none )



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- View


renderScore : Hole -> Html Msg
renderScore hole =
    Html.td [] [ Html.input [ type_ "number", onInput (UpdateScore hole) ] [] ]



-- Html.td [] [ Html.input [ type_ "number", onInput (UpdateScore hole) ] [] ]


renderHoleNum : Hole -> Html Msg
renderHoleNum hole =
    Html.td [] [ Html.text <| toString hole.holeNum ]


renderHolePar : Hole -> Html Msg
renderHolePar hole =
    Html.td [] [ Html.text <| toString hole.par ]


renderCourse : Model -> Html Msg
renderCourse { course } =
    Html.table []
        [ Html.tr []
            ([ Html.td [] [ Html.text "Hole" ] ] ++ List.map renderHoleNum course)
        , Html.tr []
            ([ Html.td [] [ Html.text "Par" ] ] ++ List.map renderHolePar course)
        , Html.tr []
            ([ Html.td [] [ Html.input [ type_ "textarea" ] [] ] ] ++ List.map renderScore course)
        ]



-- renderModelInfo : Model -> Html Msg
-- renderModelInfo model =
--     Html.pre []
--         [ Html.hr [] []
--         , Html.text <| toString model
--         ]


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.h1 []
            [ Html.text "Score Card" ]
        , (renderCourse model)
        , Html.h1 [] [ Html.text <| toString model.score ]
        , Html.button [ onClick Birdie ] [ Html.text "Birdie" ]
        , Html.button [ onClick Par ] [ Html.text "Par" ]
        , Html.button [ onClick Bogey ] [ Html.text "Bogey" ]
          -- , (renderModelInfo model)
        ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
