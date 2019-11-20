cuadricula(X,Y):-0<X,X<6,0<Y,Y<6.
manhattan(Pos1,Pos1,[]).



manhattan(cuadricula(X1,Y1),cuadricula(X2,Y2),[cuadricula(X,Y)|L]):- X is X1+1,
							      Y is Y1,
							      cuadricula(X,Y),
							      manhattan(cuadricula(X,Y),cuadricula(X2,Y2),L).
manhattan(cuadricula(X1,Y1),cuadricula(X2,Y2),[cuadricula(X,Y)|L]):- X is X1-1,
							      Y is Y1,
							      cuadricula(X,Y),
							      manhattan(cuadricula(X,Y),cuadricula(X2,Y2),L).
manhattan(cuadricula(X1,Y1),cuadricula(X2,Y2),[cuadricula(X,Y)|L]):- X is X1,
							      Y is Y1+1,
							      cuadricula(X,Y),
							      manhattan(cuadricula(X,Y),cuadricula(X2,Y2),L).
manhattan(cuadricula(X1,Y1),cuadricula(X2,Y2),[cuadricula(X,Y)|L]):- X is X1,
							      Y is Y1-1,
							      cuadricula(X,Y),
							     manhattan(cuadricula(X,Y),cuadricula(X2,Y2),L).