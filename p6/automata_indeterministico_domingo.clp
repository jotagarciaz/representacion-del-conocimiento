(deffacts automata
(trans q0 "0" q0 q1)
(trans q0 "1" q0)
(trans q1 "0" q2)
(final q2)
(final q0))

(defrule transicion
  ?estado <-(estado ?estado_actual $?otros_estados entrada ?simbolo_actual $?otros)
  (trans ?estado_actual ?simbolo_actual $?siguientes_estados)
 =>
  (assert (estado $?otros_estados entrada ?simbolo_actual $?otros))
  (assert (estado ?siguientes_estados entrada $?otros))
  (printout t ?estado_actual " " ?simbolo_actual " " $?siguientes_estados crlf)
)

(defrule final_state
  ?estado <-(estado ?estado_actual $?otros_estados entrada "$")
  ?final <- (final  ?estado_actual)
  =>
  (retract ?estado)
  (assert (estado))
  (printout t "Acepta " ?estado_actual crlf)
)

(deffacts prueba
  (estado q0 entrada "0" "1" "0" "$")
)