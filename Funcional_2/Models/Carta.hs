module Models.Carta where
    data Carta = Carta {
        numero :: String,
        naipe :: String,
        valor :: Int
    }

    valorCarta :: String -> Int
    valorCarta number
        | length number == 1 = read number::Int
        | number == "As" = 11
        | otherwise = 10
    
    toString :: Carta -> String
    toString carta = numero(carta) ++ " de " ++ naipe(carta)

        