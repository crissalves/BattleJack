main :: IO()
main = do
    putStrLn "▄▄                                                                                  "
    putStrLn "▀███▀▀▀██▄          ██     ██    ▀███             ▀████▀              ▀███       ██ "
    putStrLn "  ██    ██          ██     ██      ██               ██                  ██       ██ "
    putStrLn "  ██    ██ ▄█▀██▄ ██████ ██████    ██   ▄▄█▀██      ██  ▄█▀██▄  ▄██▀██  ██  ▄██▀ ██ "
    putStrLn "  ██▀▀▀█▄▄ █   ██   ██     ██      ██  ▄█▀   ██     ██ ██   ██ ██▀  ██  ██ ▄█    ██ "
    putStrLn "  ██    ▀█ ▄█████   ██     ██      ██  ██▀▀▀▀▀▀     ██  ▄█████ ██       ██▄██    ▀▀ "
    putStrLn "  ██    ▄█ █   ██   ██     ██      ██  ██▄    ▄█ █  ██ ██   ██ ██▄    ▄ ██ ▀██▄     "
    putStrLn "▄████████▀ ████▀██▄ ▀████  ▀████ ▄████▄ ▀█████▀█ ████  ▀████▀██▄█████▀▄████▄ ██▄ ██ "  
    menuInicial 

menuInicial :: IO()
menuInicial = do
    putStrLn "\nMenu Inicial \n"
    putStrLn "1 -> Iniciar Jogo"
    putStrLn "2 -> Regras"
    putStrLn "3 -> Créditos"
    putStrLn "4 -> Sair"
    putStrLn "\nSelecione o número da opção desejada: "
    opcao <- readLn :: IO Int
    escolha opcao


--Resolver o prelude.read: no parse para não quebrar o programa
escolha :: Int -> IO()
escolha opcao 
            | opcao == 1 = menuJogador
            | opcao == 2 = regras
            | opcao == 3 = creditos
            | opcao == 4 = putStrLn "Obrigador por jogar :D"
            | otherwise = do
                putStrLn "Escolha uma opção válida"
                menuInicial


regras :: IO()
regras = do
    putStrLn "\nRegras: \n"
    putStrLn "Existem dois modos, o modo dealer e o modo JxJ (jogador vs jogador)"
    putStrLn "Inicialmente os jogadores teram 200 de vida, e o jogo acabará quando algum dos jogadores chegar a 0."
    putStrLn "Cada jogador terá duas opções quando chegar sua vez: \n"
    putStrLn "Pedir Carta: Onde o jogador irá receber uma carta aleatória que pode possuir o valor de 1 a 11"
    putStrLn "Parar: É quando o jogador decide parar de puxar e aguarda o oponente parar também para contabilizar os danos."
    putStrLn "\nUm caso especial é a carta A ela normalmente valerá 11, porém se o jogador possuir duas cartas de valor 10, ela valerá apenas 1."
    putStrLn "As cartas J Q K valeram 10, e as outras cartas valerão seus respectivos valores."
    putStrLn "\nO dano é contabilizado a vida do adversário considerando a soma dos valores de suas cartas, porém existem algumas condições para deixar o jogo mais interessante."
    putStrLn "As condições de contabilização de danos são essas: \n"
    putStrLn "Caso o jogador consiga exatos 21 ele causara 10 de dano somados a suas cartas, que são 21 ou seja ele causará 31 de dano ao inimigo."
    putStrLn "Caso o jogador Estoure a mão, ou seja passe do valor 21, ele não causará dano no inimigo, e tomará um acréscimo de 10 dano + o dano do inimigo."
    putStrLn "\nEm caso de empate, será realizado uma rodada da morte que será da seguinte forma: \n"
    putStrLn "Primeiro será realizado um cara ou coroa de forma aleatória, para decidir quem puxa carta primeiro."
    putStrLn "Cada jogador irá puxar cartas aleatórias e quem estourar a mão primeir (passar de 21) perde."
    
    putStrLn "\nPressione Enter para voltar ao menu Inicial."
    x <- getLine
    menuInicial


creditos :: IO()
creditos = do
    putStrLn "\nEquipe : \n"
    putStrLn "Cristian Alves da Silva. 119211092"
    putStrLn "José Erik"
    putStrLn "Lucas Oliveira"
    putStrLn "\nProjeto realizado para disciplina de Paradigmas de Linguagem da Computação, do Curso Ciências da Computação na Universidade Federal de Campina Grande."
    putStrLn "Feito para termos melhor conhecimento da programação funcional utilizando a linguagem de programação haskell."
    putStrLn "\nPressione Enter para voltar ao menu Inicial"
    x <- getLine
    menuInicial


menuJogador :: IO()
menuJogador = do
    putStrLn "Inicializando..."
    putStrLn "\nEscolha qual modo de jogo: \n"
    putStrLn "1 -> Jogador vs IA"
    putStrLn "2 -> Jogador vs Jogador"
    putStrLn "3 -> Jogador vs Jogador + Dealer"
    putStrLn "\nSelecione a opção desejada: "
    opcao <- readLn :: IO Int
    escolhaModo opcao

escolhaModo :: Int -> IO ()
escolhaModo opcao
                | opcao == 1 = putStrLn "Contra IA"
                | opcao == 2 = putStrLn "JxJ"
                | opcao == 3 = putStrLn "JxJ (dealer)"

