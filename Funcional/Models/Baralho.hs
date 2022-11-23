module Models.Baralho where
    import Models.Carta
    
    data Baralho = Baralho {
         numCartas :: [String],
         naipeCartas :: [String]
    }

    pedirCarta :: Int -> Int -> Baralho -> Carta
    pedirCarta num naipe baralho = Carta (numCartas(baralho)!!num) (naipeCartas(baralho)!!naipe) (valorCarta(numCartas(baralho)!!num)) 