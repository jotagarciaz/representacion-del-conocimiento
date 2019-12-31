(deffacts automata
(trans q0 "0" q3)
(trans q0 "1" q1)
(trans q1 "1" q2)
(trans q2 "0" q2)
(trans q3 "0" q1)
(final q2)
(inicial q0))

(defrule transicion
	?estado <- (estado ?estado_actual palabra $?caracteres)
	(trans ?estado_siguiente ?nuevo_caracter ?estado_actual)
	=> 
	(retract ?estado)
	(assert (estado ?estado_siguiente palabra ?nuevo_caracter $?caracteres))
)

(defrule parada
	(estado ?q palabra $?caracteres)
	(inicial ?q)
	=>
	(printout t "Palabra: " $?caracteres crlf)
)