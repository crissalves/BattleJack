:- initialization(main).
:- include('jogo.pl').

main:-
    write( '▄▄                                                                                  '),
    write( '▀███▀▀▀██▄          ██     ██    ▀███             ▀████▀              ▀███       ██ '),
    write( '  ██    ██          ██     ██      ██               ██                  ██       ██ '),
    write( '  ██    ██ ▄█▀██▄ ██████ ██████    ██   ▄▄█▀██      ██  ▄█▀██▄  ▄██▀██  ██  ▄██▀ ██ '),
    write( '  ██▀▀▀█▄▄ █   ██   ██     ██      ██  ▄█▀   ██     ██ ██   ██ ██▀  ██  ██ ▄█    ██ '),
    write( '  ██    ▀█ ▄█████   ██     ██      ██  ██▀▀▀▀▀▀     ██  ▄█████ ██       ██▄██    ▀▀ '),
    write( '  ██    ▄█ █   ██   ██     ██      ██  ██▄    ▄█ █  ██ ██   ██ ██▄    ▄ ██ ▀██▄     '),
    write( '▄████████▀ ████▀██▄ ▀████  ▀████ ▄████▄ ▀█████▀█ ████  ▀████▀██▄█████▀▄████▄ ██▄ ██ '),
    menuInicial.
    
    
menuInicial:-
    nl,nl,write('Menu Inicial'),
    nl,write('1 -> Iniciar Jogo'),
    nl,write('2 -> Regras'),
    nl,write('3 -> Creditos'),
    nl,write('4 -> Sair'),
    nl,write('Selecione o numero da opcao desejada: '),
    read_line_to_string(user_input,Opcao),
    escolha(Opcao).


escolha("1"):-
    nl,nl,write('Inicializando...'),
    nl,write('\nEscolha qual modo de jogo: \n'),
    nl,write('1 -> Jogador vs IA'),
    nl,write('2 -> Jogador vs Jogador'),
    nl,write('\nSelecione a opçao desejada: '),
    read_line_to_string(user_input,OpcaoJogador),
    modoDeJogo(OpcaoJogador).

modoDeJogo("1"):-
    jogoVSIA,
    menuInicial.


modoDeJogo("2"):-
    jogoVSjogador,
    meunInicial.


escolha("2"):- 
    nl,nl,write('\nRegras: \n'),
    nl,write('Existem dois modos, o modo JxIA(Jogador vs IA) e o modo JxJ (jogador vs jogador)'),
    nl,write('Inicialmente os jogadores teram 100 de vida, e o jogo acabará quando algum dos jogadores chegar a 0.'),
    nl,write('Cada jogador terá duas opções quando chegar sua vez: '),nl,
    nl,write('Pedir Carta: Onde o jogador irá receber uma carta aleatória que pode possuir o valor de 1 a 11'),
    nl,write('Parar: É quando o jogador decide parar de puxar e aguarda o oponente parar também para contabilizar os danos.'),
    nl,write('\nUm caso especial é a carta A ela normalmente valerá 11, porém se o jogador possuir duas cartas que juntas valem mais que 10, ela valerá apenas 1.'),
    nl,write('As cartas J Q K valeram 10, e as outras cartas valerão seus respectivos valores.'),
    nl,write('\nO dano é contabilizado a vida do adversário considerando a soma dos valores de suas cartas, porém existem algumas condições para deixar o jogo mais interessante.'),
    nl,write('As condições de contabilização de danos são essas: '),nl,
    nl,write('Caso o jogador consiga exatos 21 ele causara 10 de dano somados a suas cartas, que são 21 ou seja ele causará 31 de dano ao inimigo.'),
    nl,write('Caso o jogador Estoure a mão, ou seja passe do valor 21, ele não causará dano no inimigo, e tomará um acréscimo de 10 dano + o dano do inimigo.'),
    nl,write('Em caso de empate, será realizado uma rodada da morte que será da seguinte forma: '),nl,
    nl,write('Primeiro será realizado um cara ou coroa de forma aleatória, para decidir quem puxa carta primeiro.'),
    nl,write('Cada jogador irá puxar cartas aleatórias e quem estourar a mão primeiro (passar de 21) perde.'),
    nl,nl,write('Pressione Enter para voltar ao menu Inicial.'),
    read_line_to_string(user_input,_),
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