;(assert (trans q0 1 q1))
;(assert (trans q0 0 q3))
;(assert (trans q1 1 q2))
;(assert (trans q2 0 q2))
;(assert (trans q3 0 q1))
;(assert (final q2))
;(assert (inicial q0))

(defrule transicion
	?estado -> (estado ?estado_actual palabra $?caracteres)
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