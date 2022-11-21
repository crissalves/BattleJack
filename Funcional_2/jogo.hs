module Jogo where
--import Models.Jogador 
import Models.Jogador
import Models.Carta
import Models.Baralho
import System.Random
--calcularDano :: Int -> Int -> Int 
--calcularDano x y =
jogo :: IO()
jogo = do
    putStrLn "\nAntes de começar o jogo"
    putStrLn "Digite o seu nome como Jogador:"

    nomePlayer <- getLine
    putStrLn ("\nBem-vindo ao jogo BattleJack, " ++ nomePlayer)
    putStrLn "Agora... Prepare-se para a BATALHA"


    let jogador = Jogador nomePlayer 100 [] False
    let ia = Jogador "Robo I.A." 100 [] False
    prepararRodada jogador ia

prepararRodada :: Jogador -> Jogador -> IO()
prepararRodada jogador ia = do
    putStrLn "\nPreparando rodada... \n"
    let baralho = Baralho ["As","2","3","4","5","6","7","8","9","10","Valete","Rainha","Rei"] ["Copas","Espadas","Paus","Ouros"]
    iniciarJogo baralho jogador ia 

iniciarJogo :: Baralho -> Jogador -> Jogador -> IO()
iniciarJogo baralho jogador ia = do
    putStrLn ("\n" ++ (nome jogador) ++ " e " ++ (nome ia) ++ " se encaram e estão prontos para o duelo")
    putStrLn "Os dois puxam uma carta para suas mãos"
    putStrLn ("O jogo mental acaba de começar.")

    num1 <- randomRIO(0,13::Int)
    naipe1 <- randomRIO(0,3::Int)
    num2 <- randomRIO(0,13::Int)
    naipe2 <- randomRIO(0,3::Int)

    let carta1 = puxarCarta num1 naipe1 baralho
    let carta2 = puxarCarta num2 naipe2 baralho
    let jogadorAtt = adicionarCarta jogador carta1
    let iaAtt = adicionarCarta ia carta2
    putStrLn ("\nAs cartas de " ++ (nome jogador) ++ ":")
    putStrLn (mostrarMao(mao(jogadorAtt)))
    putStrLn ("\nAs cartas de " ++ (nome ia) ++ ":")
    putStrLn (mostrarMao(mao(iaAtt)))

    batalha baralho jogadorAtt iaAtt

batalha :: Baralho -> Jogador -> Jogador -> IO()
batalha baralho jogador ia = do
    if(parou(jogador) && parou(ia)) then aplicarDano jogador ia baralho
    else if(parou(jogador)) then turnoIA baralho jogador ia  
    else do 
        putStrLn "\nQual decisão irá tomar agora: \n"
        putStrLn "1 -> Pedir carta"
        putStrLn "2 -> Parar"
        putStrLn "Selecione uma dessa opções:"
    
        opcao <- getLine
        if(opcao == "1") then do
         num <- randomRIO(0,13::Int)
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
            batalha baralho jogadorAtt2 ia
         else if(parou(ia)) then batalha baralho jogadorAtt ia
         else turnoIA baralho jogadorAtt ia

        else do
            let jogadorAtt = decidirParar jogador
            batalha baralho jogadorAtt ia


turnoIA :: Baralho -> Jogador -> Jogador -> IO()
turnoIA baralho jogador ia = do
      putStrLn "Vez do adversário"
      if(estourouMao(ia) || danoTotal(mao(ia)) > 16) then do
        putStrLn "O adversário decidiu parar"
        let iaAtt = decidirParar ia
        batalha baralho jogador iaAtt
      else do 
        putStrLn "Ao puxar a carta do baralho, ele adiciona a sua mão"
        num <- randomRIO(0,13::Int)
        naipe <- randomRIO(0,3::Int)
        let carta = puxarCarta num naipe baralho
        let iaAtt = adicionarCarta ia carta
        batalha baralho jogador iaAtt

aplicarDano :: Jogador -> Jogador -> Baralho -> IO()
aplicarDano jogador ia baralho = do
    putStrLn "\nOs dois jogadores decidiram parar e revelar suas cartas para o outro"
    putStrLn "A mesa mostra as cartas de ambos os jogadores viradas para cima"
    putStrLn ("\nAs cartas de " ++ (nome jogador) ++ ":")
    putStrLn (mostrarMao(mao(jogador)))
    putStrLn ("\nAs cartas de " ++ (nome ia) ++ ":")
    putStrLn (mostrarMao(mao(ia)))
    putStrLn "Está no momento do ataque ser aplicado"
    putStrLn "\nAperte Enter para continuar"
    z <- getLine

    let danoJ = calculardano (danoTotal(mao(jogador))) (estourouMao(ia))
    let danoIA = calculardano (danoTotal(mao(ia))) (estourouMao(jogador))
    
    let jogadorAtt = alterarVida jogador danoIA
    let iaAtt = alterarVida ia danoJ

    putStrLn "\nAs cartas se estremecem na tensão que está no ar"
    putStrLn "Ploft! Clack!"
    putStrLn (nome(jogador) ++ " aplica um total de dano no adversário de: " ++ show danoJ)
    putStrLn "Puft! Lau!"
    putStrLn (nome(ia) ++ " aplica um total de dano no adversário de: " ++ show danoIA)

    putStrLn "\nAperte Enter para continuar"
    x <- getLine
    putStrLn "Após os ataques cessarem vamos ver o que resta dos jogadores..."
    putStrLn ("A vida atual de " ++ nome(jogador) ++ " é " ++ show(vida(jogadorAtt)))
    putStrLn ("A vida atual de " ++ nome(ia) ++ " é " ++ show(vida(iaAtt)))

    if(zerouVida(jogador) || zerouVida(ia)) then resultado jogadorAtt iaAtt
    else do
        putStrLn "Depois da tensão da batalha, os dois jogadores voltam para a mesa sem cartas na mão"
        putStrLn "Aperte Enter para ir para próxima rodada"
        y <- getLine
        let jogadorAtt2 = reiniciarJogador jogadorAtt
        let iaAtt2 = reiniciarJogador iaAtt
        if(zerouVida(jogador) && zerouVida(ia)) then desempate jogadorAtt2 iaAtt2 baralho
        else prepararRodada jogadorAtt2 iaAtt2

resultado :: Jogador -> Jogador -> IO()
resultado jogador ia = do
    putStrLn "Temos um vencedor..."
    putStrLn "Depois de todas as batalhas travadas com auxilio do poder das cartas"
    putStrLn "Um triunfante jogador se ergue no campo de batalha: "
    if(zerouVida(jogador)) then putStrLn (nome(ia) ++ " é o GRANDE VENCEDOR")
    else putStrLn (nome(jogador) ++ " é o GRANDE VENCEDOR")

desempate :: Jogador -> Jogador -> Baralho -> IO()
desempate jogador ia baralho = do
    putStrLn "Os dois jogadores empataram e agora vai rolar o desafio FINAL!"
    putStrLn "O desempate irá acontecer da seguinte forma.."
    putStrLn "Cada jogador irá pegar uma carta por vez até algum dos dois estourar primeiro"
    putStrLn "Aperte Enter se entendeu."
    x <- getLine

    rodadaDesempate jogador ia baralho True

   
rodadaDesempate :: Jogador -> Jogador -> Baralho -> Bool -> IO()
rodadaDesempate jogador ia baralho vezJogador = do
    if(vezJogador) then do
        num <- randomRIO(0,13::Int)
        naipe <- randomRIO(0,3::Int)
        let carta = puxarCarta num naipe baralho
        let jogadorAtt = adicionarCarta jogador carta

        putStrLn (nome(jogador) ++ " puxa a carta do baralho")
        putStrLn ("\nAs cartas de " ++ (nome jogador) ++ ":")
        putStrLn (mostrarMao(mao(jogadorAtt)))
        if(estourouMao(jogadorAtt)) then do
         putStrLn "Infelizmente você perdei :("

        else rodadaDesempate jogadorAtt ia baralho True
    else do
        num <- randomRIO(0,13::Int)
        naipe <- randomRIO(0,3::Int)
        let carta = puxarCarta num naipe baralho
        let iaAtt = adicionarCarta ia carta

        putStrLn (nome(ia) ++ " puxa a carta do baralho")
        putStrLn ("\nAs cartas de " ++ (nome ia) ++ ":")
        putStrLn (mostrarMao(mao(iaAtt)))
        if(estourouMao(iaAtt)) then do
         putStrLn "Parabéns você ganhou"
        else rodadaDesempate jogador iaAtt baralho False

   
puxarCarta :: Int-> Int -> Baralho -> Carta
puxarCarta num naipe baralho = pedirCarta num naipe baralho

calculardano :: Int -> Bool -> Int
calculardano dmg adicional 
        | dmg > 21 = 0
        | dmg == 21 && adicional = dmg + 20
        | dmg == 21 = dmg + 10
        | adicional = dmg + 10
        | otherwise = dmg

    


