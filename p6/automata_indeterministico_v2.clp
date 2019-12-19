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
  ?estados <-(estados $?estados_otros)
 =>
  (retract ?simbolo)
  (retract ?cinta)
  (retract ?estado)
  (retract ?trans)
  (retract ?estados)
  (assert (estado ?siguiente_estado))
  (assert (estados $?otros_estados $?estados_otros))
  (assert (caracter ?siguiente_simbolo))
  (assert (entrada $?otros))
  (printout t ?estado_actual " " ?simbolo_actual " " ?siguiente_estado crlf)
)

(defrule recorrer_estados
  ?estado_actual <-(estado)
  ?estados <-(estados ?siguiente_estado $?otros_estados)
 =>
  (retract ?estado_actual)
  (retract ?estados)
  (assert (estado ?siguiente_estado))
  (assert (estados $?otros_estados))
)

(defrule final_state
  ?estado <-(estado ?estado_actual)
  ?final <- (final  ?estado_actual)
  ?otros_finales_ <- (estados_finales $?otros_finales)
  =>
  (retract ?otros_finales_)
  (retract ?estado)
  (assert (estados_finales $?otros_finales ?estado_actual))
  (printout t "fallo aqui" crlf)
)

(defrule fin_carrete
  ?simbolo <-(caracter "$")
  =>
  (printout t "fin de carrete" crlf)
)

(deffacts prueba
  (estado q0)
  (estados_finales)
  (estados)
  (caracter "0")
  (entrada "0" "1" "0" "0" "1" "$")
)