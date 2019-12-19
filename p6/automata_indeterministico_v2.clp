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
  ?trans <-(trans ?estado_actual ?simbolo_actual $?siguientes_estados)
  ?estados <-(estados $?otros_estados)
 =>
  (retract ?simbolo)
  (retract ?cinta)
  (retract ?estado)
  (retract ?estados)
  (assert (estado))
  (assert (estados $?siguientes_estados $?otros_estados))
  (assert (caracter ?siguiente_simbolo))
  (assert (entrada $?otros ?simbolo_actual))
  (printout t ?estado_actual " " ?simbolo_actual " " $?siguientes_estados crlf)
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

(defrule estado_fallido
  ?estado_actual <-(estado qfallido)
 =>
  (retract ?estado_actual)
  (assert (estado))
)

(defrule final_state
  ?estado <-(estado ?estado_actual)
  ?final <- (final  ?estado_actual)
  ?simbolo <-(caracter "$")
  ?finales <- (estados_finales $?otros_finales)
  ?cinta <-(entrada ?siguiente_simbolo $?otros_simbolos)
  =>
  (retract ?finales)
  (retract ?estado)
  (retract ?cinta)
  (retract ?simbolo)
  (assert (estado))
  (assert (caracter ?siguiente_simbolo))
  (assert (entrada $?otros_simbolos "$"))
  (assert (estados_finales $?otros_finales ?estado_actual))
  (printout t "fallo aqui" crlf)
)

(defrule final_state_1
  ?estado <-(estado q1)
  ?simbolo <-(caracter "$")
  ?finales <- (estados_finales $?otros_finales)
  ?cinta <-(entrada ?siguiente_simbolo $?otros_simbolos)
  =>
  (retract ?finales)
  (retract ?estado)
  (retract ?cinta)
  (retract ?simbolo)
  (assert (estado))
  (assert (caracter ?siguiente_simbolo))
  (assert (entrada $?otros_simbolos "$"))
  (assert (estados_finales $?otros_finales q2))
  (printout t "fallo aqui" crlf)
)

(defrule fin_carrete
  ?estados <-(estados)
  ?finales <-(estados_finales $?estados_finales)
  =>
  (printout t "fin de carrete" crlf)
  (printout t "Acepta en: " $?estados_finales crlf)
)

(deffacts prueba
  (estado q0)
  (estados_finales)
  (estados)
  (caracter "0")
  (entrada "0" "1" "0" "1" "$")
)