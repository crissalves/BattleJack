adicionarCarta([],Carta,[Carta]).
adicionarCarta(Mao,Carta,Rmao):- Mao = [H|T],Rmao = [H|[Carta|T]].

jogador1("Lucas",100,[],false).
jogador2("Cris",100,[],false).

mostrarMao([]).
mostrarMao(Lista):- Lista = [H|T], H = [X,Y], write(X), write(" de "), write(Y),nl, mostrarMao(T).

pedirCarta(Nums, Naipes, Carta):- random(0,12,X), nth0(X,Nums,R), random(0,3,Y), nth0(Y,Naipes,R1), Carta = [R,R1].

iniciarRodada:-
	jogador1("Lucas",V1,M1,P1),
	jogador2("Cris",V2,M2,P2),
	Nums = ["A","2","3","4","5","6","7","8","9","10","Valete","Rainha", "Rei"],
	Naipes = ["Copas","Paus", "Ouros", "Espadas"],
	pedirCarta(Nums, Naipes, Carta),
	pedirCarta(Nums, Naipes, Carta2),
	pedirCarta(Nums, Naipes, Carta3),
	pedirCarta(Nums, Naipes, Carta4),
	adicionarCarta(M1,Carta,R1),
	adicionarCarta(M2,Carta2,R2),
	adicionarCarta(R1,Carta3,R3),
	adicionarCarta(R2,Carta4,R4),
	write("As cartas de J1 sao:"),
	nl,mostrarMao(R3),
	nl,
	write("As cartas do J2 sao:"),
	nl,mostrarMao(R4).

	
	
	
	
	
	

