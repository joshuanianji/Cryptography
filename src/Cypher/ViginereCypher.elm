{-
   Initially wanted to rip off code from online but nah I'm good. I don't need ports smh.

-}


module Cypher.ViginereCypher exposing (viginereDecrypt, viginereEncrypt)

import Char
import List



{-
   takes in a char list, and the desired length, and outputs the key char list but scaled

   for example let's say we have ['a', 'b', 'c'] but we want it to scale up to 10 letters long.
   We'll output ['a','b','c','a','b','c','a','b','c','a']

-}


changeKeyCharList : List Char -> Int -> List Char
changeKeyCharList list desiredLength =
    if desiredLength < List.length list then
        -- so we need to cut off the list. We do this by take, which takes the first n amount of the list
        List.take desiredLength list

    else
        -- we need to concatonate the list upon itself until it is the length of the scaleKey or above. We'll do this by recursion lol
        changeKeyCharList (list ++ list) desiredLength



-- converts a list of char to a list of keycodes (basically integers)


toKeyCodes : List Char -> List Int
toKeyCodes list =
    List.map
        Char.toCode
        list


fromKeyCodes : List Int -> List Char
fromKeyCodes list =
    List.map
        Char.fromCode
        list



{-
   takes in two char lists and outputs the actual encrypted/decrypted char list.

    oper (addition or subtraction) determines if it's a encode or decode
   the first char list is the message
   the second char list if the key
   the return is the encrypted messsage but in a char list.

-}


manipulateCharLists : (Int -> Int -> Int) -> List Char -> List Char -> List Char
manipulateCharLists oper messageList keyList =
    let
        newKeyList =
            changeKeyCharList keyList (List.length messageList)
                |> toKeyCodes

        newMessageList =
            messageList
                |> toKeyCodes
    in
    List.map2 (charOperation oper) newMessageList newKeyList
        |> fromKeyCodes



-- this is a fancier function of adding the char stuff with modulus lol
-- A - Z goes from 65-90 in char land
-- but I only work with A-Z so I have to subtract 64 then add and then move back lol.


charOperation : (Int -> Int -> Int) -> Int -> Int -> Int
charOperation oper num1 num2 =
    let
        newNum1 =
            num1 - 65

        newNum2 =
            num2 - 65
    in
    modBy 26
        (oper newNum1 newNum2)
        + 65



{-
   THE ACTUAL ENCRYPT/DECRYPT FUNCTION

   1. the message input
   2. the key input
   3. the encrypted message
-}


viginereEncrypt : String -> String -> String
viginereEncrypt message key =
    let
        messageChar =
            message |> String.toList

        keyChar =
            key |> String.toList
    in
    manipulateCharLists (+) messageChar keyChar
        |> String.fromList


viginereDecrypt : String -> String -> String
viginereDecrypt message key =
    let
        messageChar =
            message |> String.toList

        keyChar =
            key |> String.toList
    in
    manipulateCharLists (-) messageChar keyChar
        |> String.fromList
