gana(alberto, pepe).
gana(jaime, pepe).
gana(pepe, emilia).
gana(alberto, emilia).
gana(alberto, jaime).

clase(X,luchador):- 
	gana(X,_),
	gana(_,X), !.
clase(X,ganador):- 
	gana(X,_), !.
clase(X,relajado).