jogoVSjogador:-
	write("Jogador 1 digite seu nome: "),
	read_line_to_string(user_input,X),
	write("Jogador 2 digite seu nome: "),
	read_line_to_string(user_input,Y),
	criaJogador(X),nl,
	criaJogador(Y),
	iniciarRodada(X,Y).

iniciarRodada(J1,J2):-
	jogador(J1,_,M1,_),
	jogador(J2,_,M2,_),

	baralho(Nums,Naipes),
	pedirCarta(Nums, Naipes, Carta),
	pedirCarta(Nums, Naipes, Carta2),
	pedirCarta(Nums, Naipes, Carta3),
	pedirCarta(Nums, Naipes, Carta4),
	adicionarCarta(M1,Carta,R1),
	adicionarCarta(M2,Carta2,R2),
	adicionarCarta(R1,Carta3,R3),
	adicionarCarta(R2,Carta4,R4),

	atualizaMao(J1, R3),
	atualizaMao(J2, R4),
	write("As cartas de J1 sao:"),
	nl,mostrarMao(R3),
	nl,
	write("As cartas do J2 sao:"),
	nl,mostrarMao(R4),
	nl,write("Aperte Enter para continuar:"),
	read_line_to_string(user_input,X),nl,
	batalhaVSjogador(J1,J2).

batalhaVSjogador(J1,J2):-
	write("A fazer...").


baralho(["As","2","3","4","5","6","7","8","9","10","Valete","Rainha", "Rei"],["Copas","Paus", "Ouros", "Espadas"]).

adicionarCarta([],Carta,[Carta]).
adicionarCarta(Mao,Carta,Rmao):- Mao = [H|T],Rmao = [H|[Carta|T]].

mostrarMao([]).
mostrarMao(Lista):- Lista = [H|T], H = [X,Y], write(X), write(" de "), write(Y),nl, mostrarMao(T).

pedirCarta(Nums, Naipes, Carta):- random(0,12,X), nth0(X,Nums,R), random(0,3,Y), nth0(Y,Naipes,R1), Carta = [R,R1].

criaJogador(Nome):- assert(jogador(Nome,100,[],false)).
atualizaMao(Nome,Cartas):- retract(jogador(Nome,X,_,Y)), assert(jogador(Nome,X,Cartas,Y)).

:- dynamic jogador/4.



	
	
	
	
	
	

