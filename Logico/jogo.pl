jogoVSIA:-
	nl,nl,write("Antes de começar o jogo..."),
	nl,write("Jogador digite seu nome: "),
	read_line_to_string(user_input,X),
	criaJogador(X),nl,
	criaJogador("IA"),
	iniciarRodada(X,"IA").

jogoVSjogador:-
	nl,nl,write("Antes de comecar o jogo..."),
	write("Jogador 1 digite seu nome: "),
	read_line_to_string(user_input,X),
	write("Jogador 2 digite seu nome: "),
	read_line_to_string(user_input,Y),
	criaJogador(X),nl,
	criaJogador(Y),
	iniciarRodada(X,Y).

prepararRodada(J1,J2):- 
	jogador(J1,0,_,_),
	jogador(J2,0,_,_),
	atualizaMao(J1,[]),
	atualizaMao(J2, []),
	desempate(J1,J2).

prepararRodada(J1,J2):- (jogador(J1,0,_,_);jogador(J2,0,_,_)), resultado(J1,J2).
	
prepararRodada(J1,J2):-
	atualizaMao(J1, []),
	atualizaMao(J2, []),
	decidiuVoltar(J1),
	decidiuVoltar(J2),

	iniciarRodada(J1,J2).

iniciarRodada(J1,J2):-
	baralho(Nums,Naipes),
	pedirCarta(Nums, Naipes, Carta1),
	pedirCarta(Nums, Naipes, Carta2),
	
	adicionaCarta(J1,Carta1),
	adicionaCarta(J2,Carta2),

	jogador(J1,_,M1,_),
	jogador(J2,_,M2,_),
	nl,format(atom(Comeco), "~w e ~w se encaram e estão prontos para o duelo", [J1, J2]), write(Comeco),
	nl,write("Os dois puxam uma carta para suas mãos"),
	nl,write("O jogo mental acaba de começar."),
	format(atom(P1), "As cartas de ~w sao:", [J1]),
	nl,nl,write(P1),
	nl,mostrarMao(M1),
	nl,
	format(atom(P2), "As cartas de ~w sao:", [J2]),
	write(P2),
	nl,mostrarMao(M2),
	nl,write("Aperte Enter para continuar:"),
	read_line_to_string(user_input,X),nl,
	prepararBatalha(J1,J2).

prepararBatalha(J1,J2):-
	jogador(J1,_,_,true),
	jogador(J2,_,_,true),
	aplicarDano(J1,J2).

prepararBatalha(J1,"IA"):-
	jogador(J1,_,_,true),
	turnoIA(J1).

prepararBatalha(J1,J2):-
	jogador(J1,_,_,true),
	pulaLinhas,
	batalha(J2,J1).

prepararBatalha("IA",J2):- turnoIA(J2).
prepararBatalha(J1,"IA"):- batalha(J1,"IA").
prepararBatalha(J1,J2):- pulaLinhas, batalha(J1,J2).

batalha(J1,J2):-
	nl,nl,format(atom(P), "Qual decisao ira tomar agora, ~w: ", [J1]),
	write(P),nl,
	write("1 - Pedir uma carta"),nl,
	write("2 - Parar"),nl,
	write("Digite uma das alternativas acima: "),
	read_line_to_string(user_input,Escolha),
	duelo(J1,J2, Escolha).

turnoIA(Player):-
	jogador("IA",_,M,_),
	danoTotal(M,D),
	D > 16,
	nl,nl,write("A IA decidiu parar."),
	decidiuParar("IA"),
	prepararBatalha(Player,"IA").

turnoIA(Player):-
	baralho(Nums,Naipes),
	pedirCarta(Nums,Naipes, Carta),
	adicionaCarta("IA", Carta),

	nl,nl,write("Ao puxar a carta do baralho, A IA coloca ela na mao"),
	prepararBatalha(Player,"IA").


duelo(J1,J2, "1"):-
	baralho(Nums,Naipes),
	pedirCarta(Nums,Naipes, Carta),
	adicionaCarta(J1, Carta),
	Carta = [N, N1, _],
	nl,format(atom(P), "Ao puxar a carta do baralho, voce adiciona um ~w de ~w", [N,N1]),
	write(P), nl, format(atom(T), "As cartas de ~w sao: ", [J1]),
	write(T),nl,
	jogador(J1,_,M,_),
	mostrarMao(M),nl,
	write("Aperte Enter para continuar: "),
	read_line_to_string(user_input,_),
	prepararBatalha(J2,J1).

duelo(J1,J2, "2"):-
	decidiuParar(J1),
	prepararBatalha(J2,J1).

aplicarDano(J1,J2):-
	jogador(J1,_,M1,_),
	jogador(J2,_,M2,_),

	nl,nl,write("Os dois jogadores decidiram parar e revelar suas cartas para o outro."),
	nl,write("A mesa mostra as cartas de ambos os jogadores viradas para cima."),
	nl,format(atom(T), "As cartas de ~w sao: ", [J1]),write(T),
	nl,mostrarMao(M1),
	nl,format(atom(X), "As cartas de ~w sao: ", [J2]),write(X),
	nl,mostrarMao(M2),
	nl,nl,write("Esta no momento do ataque ser aplicado"),
	nl,write("Aperte Enter para continuar: "),
	read_line_to_string(user_input,_),

	danoTotal(M1,Dn1),
	danoTotal(M2,Dn2),
	calcularDano(Dn1,Dn2,D1),
	calcularDano(Dn2,Dn1,D2),
	
	nl,nl,write("As cartas se estremecem na tensao que esta no ar"),
	nl,format(atom(Dano1), "~w aplica uma dano total ao inimigo de: ~0f" ,[J1,D1]) ,write(Dano1),
	nl,format(atom(Dano2), "~w aplica uma dano total ao inimigo de: ~0f" ,[J2,D2]) ,write(Dano2),
	nl,write("Aperte Enter para aplicar os danos: "),
	read_line_to_string(user_input,_),
	diminuirVida(J1, D2),
	diminuirVida(J2, D1),

	jogador(J1,V1,_,_),
	jogador(J2,V2,_,_),

	nl,write("Apos os ataques cessarem vamos ver o que resta dos jogadores..."),
	nl,format(atom(Vida1), "A vida atual de ~w e: ~w", [J1,V1]),write(Vida1),
	nl,format(atom(Vida2), "A vida atual de ~w e: ~w", [J2,V2]),write(Vida2),

	nl,nl, write("Fim da rodada, para ir para a proxima rodada..."),
	nl, write("Aperte ENTER: "),
	read_line_to_string(user_input,_),
	nl, prepararRodada(J1,J2).

resultado(J1,J2):-
	nl,write("Temos um vencedor..."),
	nl,write("Depois de todas as batalhas travadas com auxilio do poder das cartas"),
	nl,write("Um triunfante jogador se ergue no campo de batalha: "),nl,nl,
	jogador(J1,V1,_,_),
	jogador(J2,V2,_,_),
	vencedor(J1,J2,V1,V2).

vencedor(J1,J2,0,V2):- write(J2), write(" e o GRANDE VENCEDOR").
vencedor(J1,J2,V1,0):- write(J1), write(" e o GRANDE VENCEDOR").

desempate(J1,J2):-
	nl,nl,write("Os dois jogadores empataram e agora vai rolar o desafio FINAL!"),
	nl,write("O desempate ira acontecer da seguinte forma..."),
	nl,write("Cada jogador irá pegar uma carta por vez ate que algum dos dois jogadores estourem primeiro"),
	nl,nl,write("Escolha entre cara ou coroa para decidir quem vai puxar primeiro:"),
	nl,write("1 <- Cara"),
	nl,write("2 <- Coroa"),
	nl,nl,write("Selecione uma das alternativas acima, Jogador: "),
	read_line_to_string(user_input,X),

	nl,nl,write("Jogando a moeda pra cima..."),
	random(1,3,Y),
	atom_number(X,R),
	jogarMoeda(Y),
	prepararDesempate(J1,J2,R,Y).

jogarMoeda(1):- nl,write("Deu cara!").
jogarMoeda(2):- nl,write("Deu coroa!").

prepararDesempate(J1,J2,X,X):-
	nl,nl,write("Você acertou, com isso, outro jogador irá começar jogando"),
	rodadaDesempate(J2,J1).

prepararDesempate(J1,J2,_,_):-
	nl,nl,write("Você errou, com isso, você irá começar jogando"),
	rodadaDesempate(J1,J2).

rodadaDesempate(J1,J2):-
	baralho(Nums,Naipes),
	nl,nl,format(atom(P1), "Aperte Enter para puxar a carta, ~w: ", [J1]),write(P1),
	read_line_to_string(user_input,_),
	pedirCarta(Nums,Naipes, Carta),
	adicionaCarta(J1,Carta),
	jogador(J1,_,M,_),
	nl,format(atom(P2), "~w puxou uma carta, colocando-o na mao",[J1]),write(P2),
	nl,nl,format(atom(P3), "As cartas de ~w sao:", [J1]),write(P3),
	nl,mostrarMao(M),
	verificacaoFinal(J1,J2).

verificacaoFinal(J1,J2):-
	jogador(J1,_,M,_),
	estorouMao(M,true),
	nl,nl,format(atom(D), "O jogador ~w, acabou estourando, então quer dizer que...", [J1]),write(D),
	nl,nl,format(atom(T), "Parabens ~w, voce GANHOU!" ,[J2]),write(T).

verificacaoFinal(J1,J2):- rodadaDesempate(J2,J1).


pulaLinhas:- nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl.

baralho(["As","2","3","4","5","6","7","8","9","10","Valete","Rainha", "Rei"],["Copas","Paus", "Ouros", "Espadas"]).

mostrarMao([]).
mostrarMao(Lista):- Lista = [H|T], H = [X,Y,_],write("- "), write(X), write(" de "), write(Y),nl, mostrarMao(T).

pedirCarta(Nums, Naipes, Carta):- random(0,13,X), nth0(X,Nums,R), random(0,4,Y), nth0(Y,Naipes,R1), danoInicial([R,R1], Valor), Carta = [R,R1,Valor].

adicionaCarta(Nome, Carta):- jogador(Nome,_,Mao,_), append([Carta],Mao,R), atualizaMao(Nome, R), verificacao(Nome).

danoInicial(["As"|_], 11).
danoInicial(["10"|_], 10).
danoInicial(["Valete"|_],10).
danoInicial(["Rainha"|_],10).
danoInicial(["Rei"|_], 10).
danoInicial([H|_], R):- atom_number(H,X), R = X.

danoTotal([],0).
danoTotal(Mao, Dano):- Mao = [H|T], H = [_,_,Valor], danoTotal(T,Dano1), Dano is Dano1 + Valor.

calcularDano(Dano,_,0):- Dano > 21.
calcularDano(21, Ad, 41):- Ad > 21.
calcularDano(Dano, Ad, DanoR):- Ad > 21, DanoR is Dano + 10.
calcularDano(21,_,31).
calcularDano(Dano,_, DanoR):- DanoR = Dano.

verificacao(Nome):- jogador(Nome,_,M,_), estorouMao(M, true), temAs(M,true), diminuiAs(false, M, R), atualizaMao(Nome, R).
verificacao(Nome):- jogador(Nome,_,M,_), estorouMao(M, true), decidiuParar(Nome).
verificacao(_).

temAs([], false).
temAs([H|T], true):- H = [N,_,_], N = "As".
temAs([H|T], R):- temAs(T,R).

diminuiAs(_,[],[]).
diminuiAs(false,[H|T], Rmao):- H = [N,M,11], diminuiAs(true,T,Rmao1), C = [N,M,1], Rmao = [C|Rmao1].
diminuiAs(Achou,[H|T], Rmao):- diminuiAs(Achou,T,Rmao1), Rmao = [H|Rmao1].

estorouMao(Mao, R):- danoTotal(Mao,Dano), Dano > 21, R = true.
estourouMao(_, false).

criaJogador(Nome):- assert(jogador(Nome,100,[],false)).
atualizaMao(Nome,Cartas):- retract(jogador(Nome,X,_,Y)),assert(jogador(Nome,X,Cartas,Y)).
alterarVida(Nome, Vida):- retract(jogador(Nome,_,Mao,Parou)), assert(jogador(Nome,Vida,Mao,Parou)).

diminuirVida(Nome, Dano):- jogador(Nome,Vida,_,_), V is Vida - Dano, V < 0, alterarVida(Nome, 0). 
diminuirVida(Nome, Dano):- jogador(Nome,Vida,_,_), V is Vida - Dano, alterarVida(Nome, V).
decidiuParar(Nome):- retract(jogador(Nome,V,M,_)), assert(jogador(Nome,V,M,true)).
decidiuVoltar(Nome):- retract(jogador(Nome,V,M,_)), assert(jogador(Nome,V,M,false)).

:- dynamic jogador/4.



	
	
	
	
	
	

