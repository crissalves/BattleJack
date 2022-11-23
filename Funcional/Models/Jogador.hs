module Models.Jogador where
    import Models.Carta

    data Jogador = Jogador {
        nome :: String,
        vida :: Int,
        mao :: [Carta],
        parou :: Bool

    }

    alterarVida::Jogador->Int->Jogador
    alterarVida jogador dano = 
        if(vida(jogador) - dano <= 0) then Jogador (nome jogador) 0 (mao jogador) (parou jogador)
        else Jogador (nome jogador) ((vida jogador) - dano) (mao jogador) (parou jogador)

    adicionarCarta::Jogador->Carta->Jogador
    adicionarCarta jogador carta
            | temAs(mao(jogadorAtt)) && estourouMao(jogadorAtt) = Jogador (nome(jogador)) (vida(jogador)) (diminuiAs(mao(jogadorAtt))) (parou(jogador))
            | otherwise = jogadorAtt
            where jogadorAtt = Jogador (nome(jogador)) (vida(jogador)) ([carta] ++ mao(jogador)) (parou(jogador))


    danoTotal :: [Carta] -> Int
    danoTotal [] = 0
    danoTotal (h:t) = danoTotal(t) + valor(h)

    temAs :: [Carta] -> Bool
    temAs [] = False
    temAs (h:t) = if(numero(h) == "As") then True
                  else temAs(t)

    diminuiAs :: [Carta] -> [Carta]
    diminuiAs [] = []
    diminuiAs (h:t) = if(valor(h) == 11) then [Carta (numero h) (naipe h) (1)] ++ diminuiAs(t)
                      else [h] ++ diminuiAs(t)

    mostrarMao :: [Carta] -> String
    mostrarMao [] = []
    mostrarMao (h:t) = "- " ++ toString(h) ++ "\n" ++ mostrarMao(t)

    estourouMao :: Jogador -> Bool
    estourouMao jogador = danoTotal(mao(jogador)) > 21
       
    decidirParar :: Jogador -> Jogador
    decidirParar jogador = Jogador (nome jogador) (vida jogador) (mao jogador) True

    zerouVida :: Jogador -> Bool
    zerouVida jogador = vida(jogador) == 0

    reiniciarJogador :: Jogador -> Jogador
    reiniciarJogador jogador = Jogador (nome jogador) (vida jogador) [] False





