cuadricula(X,Y):-
	1=<X, X=<5,
	1=<Y, Y=<5.

manhattan(cuadricula(X,Y),cuadricula(X,Y),[]).

manhattan(cuadricula(X1,Y1),cuadricula(X2,Y2),[cuadricula(X,Y)|L]):- 
	cuadricula(X1,Y1),
	cuadricula(X2,Y2),
	X1 < X2,
	X is X1+1,
	Y is Y1,
	manhattan(cuadricula(X,Y),cuadricula(X2,Y2),L).
manhattan(cuadricula(X1,Y1),cuadricula(X2,Y2),[cuadricula(X,Y)|L]):- 
	cuadricula(X1,Y1),
	cuadricula(X2,Y2),
	X1 > X2,
	X is X1-1,
	Y is Y1,
	manhattan(cuadricula(X,Y),cuadricula(X2,Y2),L).
manhattan(cuadricula(X1,Y1),cuadricula(X2,Y2),[cuadricula(X,Y)|L]):- 
	cuadricula(X1,Y1),
	cuadricula(X2,Y2),
	Y1 < Y2,
	X is X1,
	Y is Y1+1,
	manhattan(cuadricula(X,Y),cuadricula(X2,Y2),L).
manhattan(cuadricula(X1,Y1),cuadricula(X2,Y2),[cuadricula(X,Y)|L]):-
	cuadricula(X1,Y1),
	cuadricula(X2,Y2),
	Y1 > Y2,
	X is X1,
	Y is Y1-1,
	manhattan(cuadricula(X,Y),cuadricula(X2,Y2),L).