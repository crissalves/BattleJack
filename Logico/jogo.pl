jogoVSjogador:-
	write("Jogador 1 digite seu nome: "),
	read_line_to_string(user_input,X),
	write("Jogador 2 digite seu nome: "),
	read_line_to_string(user_input,Y),
	criaJogador(X),nl,
	criaJogador(Y),
	iniciarRodada(X,Y).

iniciarRodada(J1,J2):-
	baralho(Nums,Naipes),
	pedirCarta(Nums, Naipes, Carta1),
	pedirCarta(Nums, Naipes, Carta2),
	pedirCarta(Nums, Naipes, Carta3),
	pedirCarta(Nums, Naipes, Carta4),
	atualizaMao(J1,[Carta1]),
	atualizaMao(J1,[Carta2]),
	atualizaMao(J2,[Carta3]),
	atualizaMao(J2,[Carta4]),


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

batalha(J1,J2):-
	format(atom(P), "Qual decisao ira tomar agora, ~w: ", [J1]),
	write(P),nl,
	write("1 - Pedir uma carta"),nl,
	write("2 - Parar"),nl,
	write("Digite uma das alternativas acima: "),
	read(Escolha).
	


baralho(["As","2","3","4","5","6","7","8","9","10","Valete","Rainha", "Rei"],["Copas","Paus", "Ouros", "Espadas"]).

mostrarMao([]).
mostrarMao(Lista):- Lista = [H|T], H = [X,Y], write(X), write(" de "), write(Y),nl, mostrarMao(T).

pedirCarta(Nums, Naipes, Carta):- random(0,12,X), nth0(X,Nums,R), random(0,3,Y), nth0(Y,Naipes,R1), Carta = [R,R1].

criaJogador(Nome):- assert(jogador(Nome,100,[],false)).
atualizaMao(Nome,Carta):- retract(jogador(Nome,X,Mao,Y)), append(Carta,Mao,R),assert(jogador(Nome,X,R,Y)).

:- dynamic jogador/4.



	
	
	
	
	
	

