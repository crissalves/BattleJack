module Jogo where

import Models.Jogador
import Models.Carta
import Models.Baralho
import System.Random


jogoVSIA :: IO()
jogoVSIA = do
    putStrLn "\nAntes de começar o jogo"
    putStrLn "Digite o seu nome como Jogador:"

    nomePlayer <- getLine
    putStrLn ("\nBem-vindo ao jogo BattleJack, " ++ nomePlayer)
    putStrLn "Agora... Prepare-se para a BATALHA"

    let jogador = Jogador nomePlayer 100 [] False
    let ia = Jogador "Robo I.A." 100 [] False
    prepararRodada jogador ia


jogadorXjogador :: IO()
jogadorXjogador = do
    putStrLn "Antes de começar o jogo"
    putStrLn "\nDigite o seu nome como Jogador1 :"
    nomePlayer1 <- getLine

    putStrLn "\nDigite o seu nome como Jogador2 :"
    nomePlayer2 <- getLine

    putStrLn "\nAgora... Prepare-se para a BATALHA"    
    let jogador1 = Jogador nomePlayer1 100 [] False
    let jogador2= Jogador nomePlayer2 100 [] False
    prepararRodada jogador1 jogador2


prepararRodada :: Jogador -> Jogador -> IO()
prepararRodada jogador1 jogador2 = do
    putStrLn "\nPreparando rodada... \n"
    let baralho = Baralho ["As","2","3","4","5","6","7","8","9","10","Valete","Rainha","Rei"] ["Copas","Espadas","Paus","Ouros"]
    iniciarJogo baralho jogador1 jogador2 

iniciarJogo :: Baralho -> Jogador -> Jogador -> IO()
iniciarJogo baralho jogador1 jogador2 = do
    putStrLn ("\n" ++ (nome jogador1) ++ " e " ++ (nome jogador2) ++ " se encaram e estão prontos para o duelo")
    putStrLn "Os dois puxam uma carta para suas mãos"
    putStrLn ("O jogo mental acaba de começar.")

    num1 <- randomRIO(0,12::Int)
    naipe1 <- randomRIO(0,3::Int)
    num2 <- randomRIO(0,12::Int)
    naipe2 <- randomRIO(0,3::Int)

    let carta1 = puxarCarta num1 naipe1 baralho
    let carta2 = puxarCarta num2 naipe2 baralho
    let jogador1Att = adicionarCarta jogador1 carta1
    let jogador2Att = adicionarCarta jogador2 carta2
    putStrLn ("\nAs cartas de " ++ (nome jogador1) ++ ":")
    putStrLn (mostrarMao(mao(jogador1Att)))
    putStrLn ("\nAs cartas de " ++ (nome jogador2) ++ ":")
    putStrLn (mostrarMao(mao(jogador2Att)))
    if(nome jogador2 == "Robo I.A.") then
        batalhaVSIA baralho jogador1Att jogador2Att
        else
            batalhaVSjogador baralho jogador1Att jogador2Att


batalhaVSjogador :: Baralho -> Jogador -> Jogador -> IO()
batalhaVSjogador baralho jogador1 jogador2 = do
    if(parou(jogador1) && parou(jogador2)) then aplicarDano jogador1 jogador2 baralho
    else if(parou(jogador1)) then batalhaVSjogador baralho jogador2 jogador1  
    else do 
        putStrLn ("\nQual decisão irá tomar agora, " ++ nome(jogador1) ++ ":\n")
        putStrLn "1 -> Pedir carta"
        putStrLn "2 -> Parar"
        putStrLn "Selecione uma dessa opções:"
    
        opcao <- getLine
        if(opcao == "1") then do
            num <- randomRIO(0,12::Int)
            naipe <- randomRIO(0,3::Int)
            let carta = puxarCarta num naipe baralho
            let jogador1Att = adicionarCarta jogador1 carta
            putStrLn "Ao puxar a carta do baralho, você adiciona a tua mão"
            putStrLn ("As cartas de " ++ nome(jogador1) ++ ":")
            putStrLn (mostrarMao(mao(jogador1Att)))
            putStrLn ("Enter para continuar")
            input <- getLine

            pulaLinhas --- Função para pular linha :D

            if(estourouMao(jogador1Att)) then do
                let jogador1Att2 = decidirParar jogador1Att
                batalhaVSjogador baralho jogador2 jogador1Att2
            else if(parou(jogador2)) then batalhaVSjogador baralho jogador2 jogador1Att
            else batalhaVSjogador baralho jogador2 jogador1Att

        else if(opcao == "2") then do
            let jogador1Att = decidirParar jogador1
            pulaLinhas
            batalhaVSjogador baralho jogador2 jogador1Att
        else do
          putStrLn "Escolha um valor entre as opções abaixo: \n"
          batalhaVSjogador baralho jogador1 jogador2

batalhaVSIA :: Baralho -> Jogador -> Jogador -> IO()
batalhaVSIA baralho jogador ia = do
    if(parou(jogador) && parou(ia)) then aplicarDano jogador ia baralho
    else if(parou(jogador)) then turnoIA baralho jogador ia  
    else do 
        putStrLn "\nQual decisão irá tomar agora: \n"
        putStrLn "1 -> Pedir carta"
        putStrLn "2 -> Parar"
        putStrLn "Selecione uma dessa opções:"
    
        opcao <- getLine
        if(opcao == "1") then do
            num <- randomRIO(0,12::Int)
            naipe <- randomRIO(0,3::Int)
            let carta = puxarCarta num naipe baralho
            let jogadorAtt = adicionarCarta jogador carta
            putStrLn "Ao puxar a carta do baralho, você adiciona a tua mão"
            putStrLn ("As cartas de " ++ nome(jogador) ++ ":")
            putStrLn (mostrarMao(mao(jogadorAtt)))

            if(estourouMao(jogadorAtt)) then do
                putStrLn "BOOM"
                putStrLn "Acabou estourando X("
                let jogadorAtt2 = decidirParar jogadorAtt
                batalhaVSIA baralho jogadorAtt2 ia
            else if(parou(ia)) then batalhaVSIA baralho jogadorAtt ia
            else turnoIA baralho jogadorAtt ia
        else if(opcao == "2") then do
            let jogadorAtt = decidirParar jogador
            batalhaVSIA baralho jogadorAtt ia
        else do
             putStrLn "Escolha um valor entre as opções abaixo: \n"
             batalhaVSIA baralho jogador ia


turnoIA :: Baralho -> Jogador -> Jogador -> IO()
turnoIA baralho jogador ia = do
    putStrLn "Vez do adversário"
    if(estourouMao(ia) || danoTotal(mao(ia)) > 16) then do
        putStrLn "O adversário decidiu parar"
        let iaAtt = decidirParar ia
        batalhaVSIA baralho jogador iaAtt
    else do 
        putStrLn "Ao puxar a carta do baralho, ele adiciona a sua mão"
        num <- randomRIO(0,12::Int)
        naipe <- randomRIO(0,3::Int)
        let carta = puxarCarta num naipe baralho
        let iaAtt = adicionarCarta ia carta
        batalhaVSIA baralho jogador iaAtt

   
aplicarDano :: Jogador -> Jogador -> Baralho -> IO()
aplicarDano jogador1 jogador2 baralho = do
    putStrLn "\nOs dois jogadores decidiram parar e revelar suas cartas para o outro"
    putStrLn "A mesa mostra as cartas de ambos os jogadores viradas para cima"
    putStrLn ("\nAs cartas de " ++ (nome jogador1) ++ ":")
    putStrLn (mostrarMao(mao(jogador1)))
    putStrLn ("\nAs cartas de " ++ (nome jogador2) ++ ":")
    putStrLn (mostrarMao(mao(jogador2)))
    putStrLn "Está no momento do ataque ser aplicado"
    putStrLn "\nAperte Enter para continuar"
    z <- getLine

    let danoJ = calculardano (danoTotal(mao(jogador1))) (estourouMao(jogador2))
    let danoIA = calculardano (danoTotal(mao(jogador2))) (estourouMao(jogador1))
    
    let jogador1Att = alterarVida jogador1 danoIA
    let jogador2Att = alterarVida jogador2 danoJ

    putStrLn "\nAs cartas se estremecem na tensão que está no ar"
    putStrLn (nome(jogador1) ++ " aplica um total de dano no adversário de: " ++ show danoJ)
    putStrLn (nome(jogador2) ++ " aplica um total de dano no adversário de: " ++ show danoIA)

    putStrLn "\nAperte Enter para continuar"
    x <- getLine
    putStrLn "Após os ataques cessarem vamos ver o que resta dos jogadores..."
    putStrLn ("A vida atual de " ++ nome(jogador1) ++ " é " ++ show(vida(jogador1Att)))
    putStrLn ("A vida atual de " ++ nome(jogador2) ++ " é " ++ show(vida(jogador2Att)))

    let jogador1Att2 = reiniciarJogador jogador1Att    
    let jogador2Att2 = reiniciarJogador jogador2Att
    if(zerouVida(jogador1Att) && zerouVida(jogador2Att)) then desempate jogador1Att2 jogador2Att2 baralho
    else if(zerouVida(jogador1Att) || zerouVida(jogador2Att)) then resultado jogador1Att jogador2Att
    else do
        putStrLn "\nDepois da tensão da batalha, os dois jogadores voltam para a mesa sem cartas na mão"
        putStrLn "Aperte Enter para ir para próxima rodada"
        y <- getLine
        prepararRodada jogador1Att2 jogador2Att2

resultado :: Jogador -> Jogador -> IO()
resultado jogador1 jogador2 = do
    putStrLn "\nTemos um vencedor..."
    putStrLn "Depois de todas as batalhas travadas com auxilio do poder das cartas"
    putStrLn "Um triunfante jogador se ergue no campo de batalha: \n"
    if(zerouVida(jogador1)) then putStrLn (nome(jogador2) ++ " é o GRANDE VENCEDOR")
    else putStrLn (nome(jogador1) ++ " é o GRANDE VENCEDOR")

desempate :: Jogador -> Jogador -> Baralho -> IO()
desempate jogador1 jogador2 baralho = do
    putStrLn "\nOs dois jogadores empataram e agora vai rolar o desafio FINAL!"
    putStrLn "O desempate irá acontecer da seguinte forma..."
    putStrLn "Cada jogador irá pegar uma carta por vez até que algum dos dois jogadores estourem primeiro\n"

    putStrLn "Escolha entre cara ou coroa para decidir quem vai puxar primeiro:\n"
    putStrLn "1 <- Cara"
    putStrLn "2 <- Coroa"
    putStrLn("Selecione uma das opções acima, " ++ nome(jogador1) ++ ":")

    x <- getLine
    if(x /= "1" && x /= "2") then do
        putStrLn "\nEscolha uma opção existente entre 1 e 2"
        desempate jogador1 jogador2 baralho
    else do 
        putStrLn "\nJogando a moeda pra cima..."
        y <- randomRIO(0,1::Int)
        let num = read x::Int
        let acertou = caraOuCoroa y num
        if(y == 0) then
            putStrLn "Deu Cara"
        else
            putStrLn "Deu Coroa"
    
        if(acertou == True) then do
            putStrLn("\nO jogador " ++ nome(jogador2) ++ " vai começar puxando\n")
            rodadaDesempate jogador1 jogador2 baralho False
        else do
            putStrLn("\nO jogador " ++ nome(jogador1) ++ " vai começar puxando\n")
            rodadaDesempate jogador1 jogador2 baralho True
          
    

   
rodadaDesempate :: Jogador -> Jogador -> Baralho -> Bool -> IO()
rodadaDesempate jogador1 jogador2 baralho vezJogador = do
    if(vezJogador) then do
        num <- randomRIO(0,12::Int)
        naipe <- randomRIO(0,3::Int)
        let carta = puxarCarta num naipe baralho
        let jogador1Att = adicionarCarta jogador1 carta

        putStrLn("Aperte Enter para puxar a carta de " ++ nome(jogador1))
        input <- getLine

        putStrLn (nome(jogador1) ++ " puxa a carta do baralho")
        putStrLn ("\nAs cartas de " ++ (nome jogador1) ++ ":")
        putStrLn (mostrarMao(mao(jogador1Att)))
        if(estourouMao(jogador1Att)) then do
          putStrLn("Parabéns " ++ nome(jogador2) ++ ", você ganhou") 
        else rodadaDesempate jogador1Att jogador2 baralho False
    else do
        num <- randomRIO(0,12::Int)
        naipe <- randomRIO(0,3::Int)
        let carta = puxarCarta num naipe baralho
        let jogador2Att = adicionarCarta jogador2 carta

        putStrLn("Aperte Enter para puxar a carta de " ++ nome(jogador2))
        input <- getLine

        putStrLn (nome(jogador2) ++ " puxa a carta do baralho")
        putStrLn ("\nAs cartas de " ++ (nome jogador2) ++ ":")
        putStrLn (mostrarMao(mao(jogador2Att)))
        if(estourouMao(jogador2Att)) then do
          putStrLn("Parabéns " ++ nome(jogador1) ++ ", você ganhou") 
        else rodadaDesempate jogador1 jogador2Att baralho True

   
puxarCarta :: Int-> Int -> Baralho -> Carta
puxarCarta num naipe baralho = pedirCarta num naipe baralho

calculardano :: Int -> Bool -> Int
calculardano dmg adicional 
        | dmg > 21 = 0
        | dmg == 21 && adicional = dmg + 20
        | dmg == 21 = dmg + 10
        | adicional = dmg + 10
        | otherwise = dmg

pulaLinhas ::IO()
pulaLinhas = do
    putStrLn("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")

caraOuCoroa :: Int -> Int -> Bool
caraOuCoroa x y = 
    if(x == (y-1)) then True
    else False 
      