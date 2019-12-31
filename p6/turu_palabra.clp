(defrule parada
	(estado ?q)
	(inicial ?q)
	?palabra -> (palabra $?caracteres)
	=>
	(printout t "Palabra: " $?caracteres crlf)
)