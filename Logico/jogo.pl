jogoVSjogador:-
	write("Jogador 1 digite seu nome: "),
	read_line_to_string(user_input,X),
	write("Jogador 2 digite seu nome: "),
	read_line_to_string(user_input,Y),
	criaJogador(X),nl,
	criaJogador(Y),
	iniciarRodada(X,Y).

prepararRodada(J1,J2):-
	atualizaMao(J1, []),
	atualizaMao(J2, []),
	iniciarRodada(J1,J2).

iniciarRodada(J1,J2):-
	baralho(Nums,Naipes),
	pedirCarta(Nums, Naipes, Carta1),
	pedirCarta(Nums, Naipes, Carta2),
	pedirCarta(Nums, Naipes, Carta3),
	pedirCarta(Nums, Naipes, Carta4),
	adicionaCarta(J1,Carta1),
	adicionaCarta(J1,Carta2),
	adicionaCarta(J2,Carta3),
	adicionaCarta(J2,Carta4),

	jogador(J1,_,M1,_),
	jogador(J2,_,M2,_),
	write("As cartas de J1 sao:"),
	nl,mostrarMao(M1),
	nl,
	write("As cartas do J2 sao:"),
	nl,mostrarMao(M2),
	nl,write("Aperte Enter para continuar:"),
	read_line_to_string(user_input,X),nl,
	batalha(J1,J2).

prepararBatalha(J1,J2):-
	jogador(J1,_,_,true),
	jogador(J2,_,_,true),
	aplicarDano(J1,J2).

prepararBatalha(J1,J2):-
	jogador(J1,_,_,true),
	batalha(J2,J1).

prepararBatalha(J1,J2):- batalha(J1,J2).


batalha(J1,J2):-
	format(atom(P), "Qual decisao ira tomar agora, ~w: ", [J1]),
	write(P),nl,
	write("1 - Pedir uma carta"),nl,
	write("2 - Parar"),nl,
	write("Digite uma das alternativas acima: "),
	read_line_to_string(user_input,Escolha),
	duelo(J1,J2, Escolha).

duelo(J1,J2, "1"):-
	baralho(Nums,Naipes),
	pedirCarta(Nums,Naipes, Carta),
	adicionaCarta(J1, Carta),
	Carta = [N, N1, _],
	nl,format(atom(P), "Ao puxar a carta do baralho, voce adiciona um ~w de ~w", [N,N1]),
	write(P), nl, format(atom(T), "As cartas de ~w são: ", [J1]),
	write(T),nl,
	jogador(J1,_,M,_),
	mostrarMao(M),nl,
	write("Aperte Enter para continuar: "),
	read_line_to_string(user_input,_),
	pulaLinhas,
	prepararBatalha(J2,J1).

duelo(J1,J2, "2"):-
	decidiuParar(J1),
	pulaLinhas,
	prepararBatalha(J2,J1).

aplicarDano(J1,J2):-
	jogador(J1,_,M1,_),
	jogador(J2,_,M2,_),

	nl,write("Os dois jogadores decidiram parar e revelar suas cartas para o outro."),
	nl,write("A mesa mostra as cartas de ambos os jogadores viradas para cima."),
	nl,format(atom(T), "As cartas de ~w são: ", [J1]),write(T),
	nl,mostrarMao(M1),
	nl,format(atom(X), "As cartas de ~w são: ", [J2]),write(X),
	nl,mostrarMao(M2),
	nl,nl,write("Está no momento do ataque ser aplicado"),
	nl,write("Aperte Enter para continuar: "),
	read_line_to_string(user_input,_),

	danoTotal(M1,D1),
	danoTotal(M2,D2),

	alterarVida(J1, D2),
	alterarVida(J2, D1),

	jogador(J1,V1,_,P1),
	jogador(J2,V2,_,P2),

	nl,nl,write("As cartas se estremecem na tensão que está no ar"),
	nl,format(atom(Dano1), "~w aplica uma dano total ao inimigo de: ~0f" ,[J1,D1]) ,write(Dano1),
	nl,format(atom(Dano2), "~w aplica uma dano total ao inimigo de: ~0f" ,[J2,D2]) ,write(Dano2),
	nl,write("Aperte Enter para aplicar os danos: "),
	read_line_to_string(user_input,_),

	nl,write("Após os ataques cessarem vamos ver o que resta dos jogadores..."),
	nl,format(atom(Vida1), "A vida atual de ~w e: ~w", [J1,V1]),write(Vida1),
	nl,format(atom(Vida2), "A vida atual de ~w e: ~w", [J2,V2]),write(Vida2),

	nl, write("Fim de rodada, vamos para next"),
	nl, prepararRodada(J1,J2).
	



pulaLinhas:- nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl,nl.

baralho(["As","2","3","4","5","6","7","8","9","10","Valete","Rainha", "Rei"],["Copas","Paus", "Ouros", "Espadas"]).

mostrarMao([]).
mostrarMao(Lista):- Lista = [H|T], H = [X,Y,_], write(X), write(" de "), write(Y),nl, mostrarMao(T).

pedirCarta(Nums, Naipes, Carta):- random(0,12,X), nth0(X,Nums,R), random(0,3,Y), nth0(Y,Naipes,R1), calcularDano([R,R1], Valor), Carta = [R,R1,Valor].

calcularDano(["As"|_], 11).
calcularDano(["10"|_], 10).
calcularDano(["Valete"|_],10).
calcularDano(["Rainha"|_],10).
calcularDano(["Rei"|_], 10).
calcularDano([H|_], R):- atom_number(H,X), R = X.

danoTotal([],0).
danoTotal(Mao, Dano):- Mao = [H|T], H = [_,_,Valor], danoTotal(T,Dano1), Dano is Dano1 + Valor.

criaJogador(Nome):- assert(jogador(Nome,100,[],false)).
atualizaMao(Nome,Cartas):- retract(jogador(Nome,X,_,Y)),assert(jogador(Nome,X,Cartas,Y)).
alterarVida(Nome, Dano):- retract(jogador(Nome,Vida,Mao,Parou)), Vida2 is Vida - Dano, assert(jogador(Nome,Vida2,Mao,Parou)).

adicionaCarta(Nome, Carta):- jogador(Nome,_,Mao,_), append([Carta],Mao,R), atualizaMao(Nome, R).

temAs([], false).
temAs([H|T], R):- H = [_,_,V], V = 11, R = true.
temAs([H|T], R):- temAs(T,R).

estorouMao(Mao, R):- danoTotal(Mao) > 21, R = true.
estourouMao(_, false).

decidiuParar(Nome):- retract(jogador(Nome,V,M,_)), assert(jogador(Nome,V,M,true)).


:- dynamic jogador/4.



	
	
	
	
	
	

