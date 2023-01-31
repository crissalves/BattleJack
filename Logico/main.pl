:- initialization(main).
:- include('jogo.pl').

main:-
    writeln( '▄▄                                                                                  '),
    writeln( '▀███▀▀▀██▄          ██     ██    ▀███             ▀████▀              ▀███       ██ '),
    writeln( '  ██    ██          ██     ██      ██               ██                  ██       ██ '),
    writeln( '  ██    ██ ▄█▀██▄ ██████ ██████    ██   ▄▄█▀██      ██  ▄█▀██▄  ▄██▀██  ██  ▄██▀ ██ '),
    writeln( '  ██▀▀▀█▄▄ █   ██   ██     ██      ██  ▄█▀   ██     ██ ██   ██ ██▀  ██  ██ ▄█    ██ '),
    writeln( '  ██    ▀█ ▄█████   ██     ██      ██  ██▀▀▀▀▀▀     ██  ▄█████ ██       ██▄██    ▀▀ '),
    writeln( '  ██    ▄█ █   ██   ██     ██      ██  ██▄    ▄█ █  ██ ██   ██ ██▄    ▄ ██ ▀██▄     '),
    writeln( '▄████████▀ ████▀██▄ ▀████  ▀████ ▄████▄ ▀█████▀█ ████  ▀████▀██▄█████▀▄████▄ ██▄ ██ '),
    menuInicial.
    
menuInicial:-
    write('\nMenu Inicial \n'),
    write('1 -> Iniciar Jogo'),
    write('2 -> Regras'),
    write('3 -> Créditos'),
    write('4 -> Sair'),
    write('\nSelecione o número da opção desejada: '),
    read(opcao),
    escolha(opcao).


escolha(1):-
    write('Inicializando...'),
    write('\nEscolha qual modo de jogo: \n'),
    write('1 -> Jogador vs IA'),
    write('2 -> Jogador vs Jogador'),
    write('\nSelecione a opção desejada: '),
    read(opcaoJogador),
    escolhaJogador(opcaoJogador).

escolhaJogador(1):-



escolhaJogador(2):- 
    jogoVSjogador,
    meunInicial.


escolha(2):- 
    write('\nRegras: \n'),
    write('Existem dois modos, o modo JxIA(Jogador vs IA) e o modo JxJ (jogador vs jogador)'),
    write('Inicialmente os jogadores teram 100 de vida, e o jogo acabará quando algum dos jogadores chegar a 0.'),
    write('Cada jogador terá duas opções quando chegar sua vez: \n'),
    write('Pedir Carta: Onde o jogador irá receber uma carta aleatória que pode possuir o valor de 1 a 11'),
    write('Parar: É quando o jogador decide parar de puxar e aguarda o oponente parar também para contabilizar os danos.'),
    write('\nUm caso especial é a carta A ela normalmente valerá 11, porém se o jogador possuir duas cartas que juntas valem mais que 10, ela valerá apenas 1.'),
    write('As cartas J Q K valeram 10, e as outras cartas valerão seus respectivos valores.'),
    write('\nO dano é contabilizado a vida do adversário considerando a soma dos valores de suas cartas, porém existem algumas condições para deixar o jogo mais interessante.'),
    write('As condições de contabilização de danos são essas: \n'),
    write('Caso o jogador consiga exatos 21 ele causara 10 de dano somados a suas cartas, que são 21 ou seja ele causará 31 de dano ao inimigo.'),
    write('Caso o jogador Estoure a mão, ou seja passe do valor 21, ele não causará dano no inimigo, e tomará um acréscimo de 10 dano + o dano do inimigo.'),
    write('\nEm caso de empate, será realizado uma rodada da morte que será da seguinte forma: \n'),
    write('Primeiro será realizado um cara ou coroa de forma aleatória, para decidir quem puxa carta primeiro.'),
    write('Cada jogador irá puxar cartas aleatórias e quem estourar a mão primeiro (passar de 21) perde.'),
    write('\nPressione Enter para voltar ao menu Inicial.1'),
    read(sair),
    menuInicial.

escolha("3"):-
    nl,nl,write('Equipe : '),
    nl,write('Cristian Alves da Silva. (crissalves)'),
    nl,write('José Erik'),
    nl,write('Lucas Oliveira Carvaho. (Tampasco)'),
    nl,write('\nProjeto realizado para disciplina de Paradigmas de Linguagem da Computação, do Curso Ciências da Computação na Universidade Federal de Campina Grande.'),
    nl,write('Feito para termos melhor conhecimento da programação funcional utilizando a linguagem de programação haskell e Prolog.'),
    nl,nl,write('\nPressione Enter para voltar ao menu Inicial'),
    read_line_to_string(user_input,_),
    menuInicial.

escolha("4"):- write('Ate a proxima!'), halt.
chamadaPrincipal(_):- 
    opcaoInvalida,
    main.