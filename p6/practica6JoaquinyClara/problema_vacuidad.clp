(deffacts automata
(trans q0 0 q2)
;(trans q0 1 q1) ;descomentar para que funcione
(trans q1 0 q6)
(trans q2 0 q3)
(trans q2 1 q4)
(trans q3 0 q5)
(trans q3 1 q4)
(trans q6 1 q7)
(trans q7 0 q8)
(inicial q0))

(defrule transicion
	?estado <- (estado ?estado_actual palabra $?caracteres)
	(trans ?estado_siguiente ?nuevo_caracter ?estado_actual)
	?ya_visitados <- (visitados $?estados_visitados)
	(not (visitados $?visitados ?estado_siguiente $?otros_visitados))
	=> 
	(retract ?estado)
	(retract ?ya_visitados)
	(assert (estado ?estado_siguiente palabra ?nuevo_caracter $?caracteres))
	(assert (visitados $?estados_visitados ?estado_actual))
	(printout t "Estoy en " ?estado_actual " con caracter " ?nuevo_caracter crlf)
)

(defrule sin_palabra
	?estado <- (estado ?estado_actual palabra $?caracteres)
	(not(trans ?estado_siguiente ?nuevo_caracter ?estado_actual))
	(not(inicial ?estado_actual))
	=>
	;(retract ?estado)
	(printout t "No hay palabra" crlf)
)


(defrule parada
	(estado ?q palabra $?caracteres)
	(inicial ?q)
	=>
	(printout t "Palabra: " $?caracteres crlf)
)

(deffacts prueba
  (estado q8 palabra "$")
  (visitados)
)