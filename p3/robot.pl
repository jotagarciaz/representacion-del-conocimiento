cuadricula(X,Y):-
	1=<X, X=<5,
	1=<Y, Y=<5.


ir(cuadricula(X,Y),cuadricula(X,Y), cuadricula(X,Y)).

ir(cuadricula(X,Y), cuadricula(XB,YB), cuadricula(XA,YA)):-
	X = XB,
	Y > YB,
	YA is Y-1,
	XA is X.

ir(cuadricula(X,Y), cuadricula(XB,YB), cuadricula(XA,YA)):-
	X = XB, 
	Y < YB,
	YA is Y+1,
	XA is X.

ir(cuadricula(X,Y), cuadricula(XB,_YB), cuadricula(XA,YA)):-
	X > XB,
	XA is X-1,
	YA is Y.

ir(cuadricula(X,Y), cuadricula(XB,_YB), cuadricula(XA,YA)):-
	X < XB,
	XA = X+1,
	YA is Y. 

% El estado se compone de tres posiciones, la posicion del robot, de la papelera y la basura.
estado(cuadricula(1,1),cuadricula(1,2), cuadricula(1,3)).

% El robot  puede soltar la basura si esta cargada y estamos al lado de la papelera.
accion(estado(Pos1, Pos1, cargada), soltar, estado(Pos1, Pos1, en_papelera)).

% El robot  puede recoger la basura si esta encima de ella.
accion(estado(Pos1,Pos2, Pos1), recoger, estado(Pos1, Pos2, cargada)).

% El robot puede moverse entre las distintas posiciones.
accion(estado(Pos1, Pos2, cargada), ir(Pos1, Pos2, Pos3), estado(Pos3, Pos2, cargada)).
accion(estado(Pos1, Pos2, Pos3), ir(Pos1, Pos3, Pos4), estado(Pos4, Pos2, Pos3)):- ir(Pos1,Pos3,Pos4).

%% Los planes empiezan en un estado y acaban en otro.

plan(Estado, Estado, []).
plan(Inicio,  Fin, [Accion1|Resto]) :-
    accion(Inicio, Accion1, Estado), plan(Estado,Fin,Resto).

:-plan(estado(cuadricula(1,1),cuadricula(1,2),cuadricula(1,3)),estado(_,_,en_papelera),Plan) ,write(Plan).