main :: IO()
main = do
    putStrLn "Boas vindas ao Battlejack !"
    menuInicial


menuInicial :: IO()
menuInicial = do
    putStrLn "\nMenu Inicial \n"
    putStrLn "1 -> Iniciar Jogo "
    putStrLn "2 -> Regras "
    putStrLn "3 -> Créditos "
    putStrLn "4 -> Sair "
    putStrLn "\nSelecione o número da opção desejada: "
    opcao <- getLine
    escolha(read opcao :: Int)


--Resolver o prelude.read: no parse para não quebrar o programa
escolha :: Int -> IO()
escolha opcao 
            | opcao == 1 = putStrLn ("Jogo")
            | opcao == 2 = regras
            | opcao == 3 = creditos
            | opcao == 4 = putStrLn ("Xau ;) volte logo")
            | otherwise = do 
                putStrLn ("Escolha uma opção válida >:(" )
                menuInicial


regras :: IO()
regras = do
    putStrLn "\nRegras : \n"
    putStrLn "Pressione Enter para voltar ao menu Inicial."
    x <- getLine
    menuInicial


creditos :: IO()
creditos = do
    putStrLn "Pessoas : \n"
    putStrLn "Pressione Enter para voltar ao menu Inicial"
    x <- getLine
    menuInicial
