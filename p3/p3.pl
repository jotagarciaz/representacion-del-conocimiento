:- op( 100, xfx, salida).
:- op( 50, xfx,:).
% Horario entre las siguientes localidades cantabras.
horario( [ santander salida 8:00, guarnizo salida 8:35, solares salida 8:55 ]).
% Empezamos en Santander salida 8:00, llegamos a  guarnizo salida 8:35, seguimos a  solares, salida 8:55
horario( [ santander salida 9:10, lierganes salida 9:25, guarnizo salida 9:55, solares salida 10:15 ]).
horario( [ santander salida 9:45, lierganes salida 10:00, guarnizo salida 10:30, solares salida 10:50 ]).
horario( [ santander salida 11:45, lierganes salida 12:00, guarnizo salida 12:30, solares salida 12:50 ]).
horario( [ santander salida 13:10, guarnizo salida 13:32, solares salida 13:45 ]).
horario( [ santander salida 14:05, guarnizo salida 14:40, solares salida 15:00 ]).
horario( [ santander salida 15:00, guarnizo salida 15:36, solares salida 15:57, beranga salida 16:13 ]).
horario( [ santander salida 16:20, lierganes salida 16:35, guarnizo salida 17:05, solares salida 17:25 ]).
horario( [ santander salida 18:05, lierganes salida 18:20, guarnizo salida 18:50, solares salida 19:10 ]).
horario( [ solares salida 9:00, guarnizo salida 9:20, lierganes salida 9:50, santander salida 10:05 ]).
horario( [ solares salida 10:25, guarnizo salida 10:50, lierganes salida 11:20, santander salida 11:35 ]).
horario( [ solares salida 11:25, guarnizo salida 11:45, santander salida 12:20 ]).
horario( [ beranga salida 12:55, solares salida 13:12, guarnizo salida 13:34, santander salida 14:10 ]).
horario( [ solares salida 13:45, guarnizo salida 13:59, santander salida 14:20 ]).
horario( [ solares salida 15:05, guarnizo salida 15:25, santander salida 16:00 ]).
horario( [ solares salida 16:30, guarnizo salida 16:50, lierganes salida 17:20, santander salida 17:35 ]).
horario( [ solares salida 18:15, guarnizo salida 18:35, lierganes salida 19:05, santander salida 19:20 ]).
horario( [ solares salida 19:15, guarnizo salida 19:35, lierganes salida 20:05, santander salida 20:20 ]).
% horario( StartPLace salida StartTime, EndPlace salida EndTime, Horario)
plan( Inicio,  Destino, [ salida(Inicio), llegada( Siguiente) | Resto]) :-
    transbordo( Inicio, Siguiente),
    resto_horario(Siguiente, Destino, Resto).

resto_horario( Sitio, Sitio, []).

resto_horario( Ahora, Destino, [ llegada( Siguiente) | Resto]) :-
    transbordo( Ahora, Siguiente), 
    resto_horario( Siguiente, Destino, Resto).

resto_horario( Sitio salida Hora1, Destino, [ esperar( Sitio, Hora1, Hora2) | Resto]) :-
    transbordo( Sitio salida Hora2, _),
    es_antes(Hora1, Hora2), 
    horario( [Sitio salida Hora2, Destino, Resto]). 
     
transbordo( Sitio1, Sitio2) :- 
    horario( List),
    concatenar( _, [Sitio1,Sitio2|_ ], List).

diferencia( H1:Min1, H2:Min2, Diff) :- 
    Diff is 60 * (H2 - H1) + Min2 - Min1.

es_antes(Hora1,Hora2):-
    diferencia(Hora1,Hora2,Diff), Diff>0.
list([]).
dist([_|L]):-list(L).

concatenar([], L,L).
concatenar([X|L1], L2, [X|L3]):- concatenar(L1,L2,L3).