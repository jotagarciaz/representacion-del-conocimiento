(deffacts automata
(trans q0 "0" q0 q1)
(trans q0 "1" q0)
(trans q1 "0" q2)
(trans q1 "1" qfallido)
(trans q2 "0" qfallido)
(trans q2 "1" qfallido)
(final q2)
(final q0))

(defrule transicion
  ?estado <-(estado ?estado_actual)
  ?simbolo <-(caracter ?simbolo_actual)
  ?cinta <-(entrada ?siguiente_simbolo $?otros)
  ?trans <-(trans ?estado_actual ?simbolo_actual ?siguiente_estado $?otros_estados)
  ?final <- (final $?estado_final)
  ?otros_finales_ <- (estados_finales $?otros_finales)
 =>
  (retract ?simbolo)
  (retract ?cinta)
  (retract ?estado)
  (retract ?trans)
  (retract ?otros_finales_)
  (assert (estado ?siguiente_estado))
  (assert (caracter ?siguiente_simbolo))
  (assert (entrada $?otros))
  (assert (estados_finales $?otros_finales $?estado_final))
  (printout t ?estado_actual " " ?simbolo_actual " " ?siguiente_estado crlf)
)



; asserts de prueba
; (assert (estado q0))
; (assert (estados_finales ))
; (assert (estados ))
; (assert (caracter "0" ))
; (assert (entrada "1" "1" "0" "0" "1" "$" ))
