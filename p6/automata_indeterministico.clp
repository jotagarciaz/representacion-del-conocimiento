(defrule transicion_q0_0
  ?estado_actual <-(estado q0)
  ?estados <-(estados q0 $?otros_estados)
  ?simbolo_actual <-(caracter "0")
  ?cinta <-(entrada  ?siguiente $?otros)
 =>
  (retract ?simbolo_actual)
  (retract ?estados)
  (retract ?cinta)
  (assert (caracter ?siguiente))
  (assert (estados q0 q1 $?otros_estados))
  (assert (entrada $?otros))
  (printout t "q0" ?siguiente crlf)
  (printout t $?otros_estados crlf)
)

(defrule transicion_q0_1
  ?estado_actual <-(estado q0)
  ?estados <-(estados q0 $?otros_estados)
  ?simbolo_actual <-(caracter "1")
  ?cinta <-(entrada  ?siguiente $?otros)
 =>
  (retract ?simbolo_actual)
  (retract ?estados)
  (retract ?cinta)
  (assert (caracter ?siguiente))
  (assert (estados q0 $?otros_estados))
  (assert (entrada $?otros))
  (printout t "q0" ?siguiente crlf)
  (printout t $?otros_estados crlf)
)

(defrule transicion_q1_0
  ?estado_actual <-(estado q1)
  ?estados <-(estados q1 $?otros_estados)
  ?simbolo_actual <-(caracter "0")
  ?cinta <-(entrada  ?siguiente $?otros)
 =>
  (retract ?simbolo_actual)
  (retract ?estados)
  (retract ?cinta)
  (assert (caracter ?siguiente))
  (assert (estados q2 $?otros_estados))
  (assert (entrada $?otros))
  (printout t "q1" ?siguiente crlf)
  (printout t $?otros_estados crlf)
)

(defrule recorrer_estados
  ?estado_actual <-(estado ?estado)
  ?estados <-(estados ?siguiente_estado $?otros_estados)
 =>
  (retract ?estado_actual)
  (retract ?estados)
  (assert (estado ?siguiente_estado))
  (assert (estados $?otros_estados))
)

(defrule final_state_q0
	?estado_actual <-(estado q0)
	?estados <- (estados ?siguiente_estado $?otros_estados)
	?simbolo_actual <-(caracter "$")
	?cinta <-(entrada)
=>
	(retract ?simbolo_actual)
	(retract ?estados)
	(assert (estados $?otros_estados))
	(printout t "q0" "Accept" crlf)
	(printout t $?otros_estados crlf)
)

(defrule final_state_q2
	?estado_actual <-(estado q2)
	?estados <- (estados ?siguiente_estado $?otros_estados)
	?simbolo_actual <-(caracter "$")
	?cinta <-(entrada)
=>
	(retract ?simbolo_actual)
	(retract ?estados)
	(assert (estados $?otros_estados))
	(printout t "q2" "Accept" crlf)
	(printout t $?otros_estados crlf)
)


; (assert (estado q0))
; (assert (caracter "0"))
; (assert (entrada "0" "c"))
