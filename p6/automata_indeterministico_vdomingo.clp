(deffacts automata
(trans q0 "0" q0 q1)
(trans q0 "1" q0)
(trans q1 "0" q2)
;(trans q1 "1" qfallido)
;(trans q2 "0" qfallido)
;(trans q2 "1" qfallido)
;(trans qfallido "1" qfallido)
(final q2)
(final q0))

(defrule transicion
  ?estado <-(estado ?estado_actual $?otros_estados entrada ?simbolo_actual $?otros)
  ;?simbolo <-(caracter ?simbolo_actual)
  (trans ?estado_actual ?simbolo_actual $?siguientes_estados)
 =>
  ;(retract ?simbolo)
  (assert (estado $?otros_estados entrada ?simbolo_actual $?otros))
  (assert (estado ?siguientes_estados entrada $?otros))
  ;(assert (estados $?siguientes_estados $?otros_estados))
  ;(assert (caracter ?siguiente_simbolo))
  ;(assert (entrada $?otros ?simbolo_actual))
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