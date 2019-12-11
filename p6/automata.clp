(defrule transicion_q0_0
  ?estado_actual <-(estado q0)
  ?simbolo_actual <-(caracter "0")
  ?cinta <-(entrada  ?siguiente $?otros)
 =>
  (retract ?estado_actual)
  (retract ?simbolo_actual)
  (retract ?cinta)
  (assert (caracter ?siguiente))
  (assert (estado q1))
  (assert (entrada $?otros))
  (printout t ?siguiente crlf)
)

(defrule transicion_q0_1
  ?estado_actual <-(estado q0)
  ?simbolo_actual <-(caracter "1")
  ?cinta <-(entrada  ?siguiente $?otros)
 =>
  (retract ?estado_actual)
  (retract ?simbolo_actual)
  (retract ?cinta)
  (assert (caracter ?siguiente))
  (assert (estado q0))
  (assert (entrada $?otros))
  (printout t ?siguiente crlf)
)

(defrule transicion_q1_0
  ?estado_actual <-(estado q1)
  ?simbolo_actual <-(caracter "0")
  ?cinta <-(entrada  ?siguiente $?otros)
 =>
  (retract ?estado_actual)
  (retract ?simbolo_actual)
  (retract ?cinta)
  (assert (caracter ?siguiente))
  (assert (estado q2))
  (assert (entrada $?otros))
  (printout t ?siguiente crlf)
)

(defrule transicion_q1_1
  ?estado_actual <-(estado q1)
  ?simbolo_actual <-(caracter "1")
  ?cinta <-(entrada  ?siguiente $?otros)
 =>
  (retract ?estado_actual)
  (retract ?simbolo_actual)
  (retract ?cinta)
  (assert (caracter ?siguiente))
  (assert (estado q1))
  (assert (entrada $?otros))
  (printout t ?siguiente crlf)
)

(defrule transicion_q2_0
  ?estado_actual <-(estado q2)
  ?simbolo_actual <-(caracter "0")
  ?cinta <-(entrada  ?siguiente $?otros)
 =>
  (retract ?estado_actual)
  (retract ?simbolo_actual)
  (retract ?cinta)
  (assert (caracter ?siguiente))
  (assert (estado q1))
  (assert (entrada $?otros))
  (printout t ?siguiente crlf)
)

(defrule transicion_q2_1
  ?estado_actual <-(estado q2)
  ?simbolo_actual <-(caracter "1")
  ?cinta <-(entrada  ?siguiente $?otros)
 =>
  (retract ?estado_actual)
  (retract ?simbolo_actual)
  (retract ?cinta)
  (assert (caracter ?siguiente))
  (assert (estado q2))
  (assert (entrada $?otros))
  (printout t ?siguiente crlf)
)

(defrule final_state_q0
	?estado_actual <-(estado q0)
	?simbolo_actual <-(caracter "$")
	?cinta <-(entrada)
=>
	(retract ?simbolo_actual)
	(printout t "Accept" crlf)
)

(defrule final_state_q2
	?estado_actual <-(estado q2)
	?simbolo_actual <-(caracter "$")
	?cinta <-(entrada)
=>
	(retract ?simbolo_actual)
	(printout t "Accept" crlf)
)


; (assert (estado q0))
; (assert (caracter "0"))
; (assert (entrada "0" "c"))
