(defrule transicion_q0_0
  ?estado_actual <-(estado q0)
  ?estados <-(estados $?otros_estados)
  ?simbolo_actual <-(caracter "0")
  ?cinta <-(entrada  ?siguiente $?otros)
 =>
  (retract ?simbolo_actual)
  (retract ?estados)
  (retract ?cinta)
  (retract ?estado_actual)
  (assert (estado))
  (assert (caracter ?siguiente))
  (assert (estados q0 q1 $?otros_estados))
  (assert (entrada $?otros "0"))
  (printout t "q00" crlf)
  (printout t "q0 q1" $?otros_estados crlf)
)


(defrule transicion_q0_1
  ?estado_actual <-(estado q0)
  ?estados <-(estados $?otros_estados)
  ?simbolo_actual <-(caracter "1")
  ?cinta <-(entrada  ?siguiente $?otros)
 =>
  (retract ?simbolo_actual)
  (retract ?estados)
  (retract ?cinta)
  (retract ?estado_actual)
  (assert (estado))
  (assert (caracter ?siguiente))
  (assert (estados q0 $?otros_estados))
  (assert (entrada $?otros "1"))
  (printout t "q01" crlf)
  (printout t "q0 " $?otros_estados crlf)
)


(defrule transicion_q1_0
  ?estado_actual <-(estado q1)
  ?estados <-(estados $?otros_estados)
  ?simbolo_actual <-(caracter "0")
  ?cinta <-(entrada  ?siguiente $?otros)
 =>
  (retract ?simbolo_actual)
  (retract ?estados)
  (retract ?cinta)
  (retract ?estado_actual)
  (assert (estado))
  (assert (caracter ?siguiente))
  (assert (estados q2 $?otros_estados))
  (assert (entrada $?otros))
  (printout t "q10" crlf)
  (printout t "q2 " $?otros_estados crlf)
)

(defrule transicion_q1_1
  ?estado_actual <-(estado q1)
  ?estados <-(estados $?otros_estados)
  ?simbolo_actual <-(caracter "1")
  ?cinta <-(entrada  ?siguiente $?otros)
 =>
  (retract ?simbolo_actual)
  (retract ?estados)
  (retract ?cinta)
  (retract ?estado_actual)
  
  (assert (estado))
  (assert (caracter ?siguiente))
  (assert (estados qfallido $?otros_estados))
  (assert (entrada $?otros))
  (assert (fallido "1"))
  (printout t "q11" crlf)
  (printout t "q1 " $?otros_estados crlf)
)

(defrule transicion_q2_0_only
  ?estado_actual <-(estado q2)
  ?estados <-(estados)
  ?simbolo_actual <-(caracter "0")
  ?cinta <-(entrada  ?siguiente $?otros)
 =>
  (retract ?simbolo_actual)
  (retract ?estados)
  (retract ?cinta)
  (retract ?estado_actual)
  (assert (estado))
  (assert (caracter ?siguiente))
  (assert (estados q2))
  (assert (entrada $?otros))
  (printout t "q20" crlf)
  (printout t "q2" crlf)
)

(defrule transicion_q2_1_only
  ?estado_actual <-(estado q2)
  ?estados <-(estados)
  ?simbolo_actual <-(caracter "1")
  ?cinta <-(entrada  ?siguiente $?otros)
 =>
  (retract ?simbolo_actual)
  (retract ?estados)
  (retract ?cinta)
  (retract ?estado_actual)
  (assert (estado))
  (assert (caracter ?siguiente))
  (assert (estados q2))
  (assert (entrada $?otros))
  (printout t "q21" crlf)
  (printout t "q2" crlf)
)

(defrule transicion_q2_0
  ?estado_actual <-(estado q2)
  ?simbolo_actual <-(caracter "0")
  ?cinta <-(entrada  ?siguiente $?otros)
 =>
  (retract ?simbolo_actual)
  (retract ?cinta)
  (retract ?estado_actual)
  (assert (estado qfallido))
  (assert (caracter ?siguiente))
  (assert (entrada $?otros "0")) ;por comprobar que este cero vaya ahi
  (printout t "q20" crlf)
)

(defrule transicion_q2_1
  ?estado_actual <-(estado q2)
  ?simbolo_actual <-(caracter "1")
  ?cinta <-(entrada  ?siguiente $?otros)
 =>
  (retract ?simbolo_actual)
  (retract ?cinta)
  (retract ?estado_actual)
  (assert (estado qfallido))
  (assert (caracter ?siguiente))
  (assert (entrada $?otros "1")) ;por comprobar que este uno vaya ahi
  (printout t "q21" crlf)
)


(defrule transicion_q0_$
  ?estado_actual <-(estado q0)
  ?estados <-(estados $?otros_estados)
  ?simbolo_actual <-(caracter "$")
  ?estados_finales <-(estados_finales $?estados_finales_otros)
  ?cinta <-(entrada  ?siguiente ?siguiente_dos $?otros)
 =>
  (retract ?simbolo_actual)
  (retract ?estados)
  (retract ?cinta)
  (retract ?estado_actual)
  (assert (estado))
  (retract ?estados_finales)
  (assert (estados_finales $?estados_finales_otros q0))
  (assert (caracter ?siguiente_dos))
  (assert (estados $?otros_estados))
  (assert (entrada $?otros "$"))
  (printout t "q0$" crlf)
  (printout t $?otros_estados crlf)
  (printout t "Accept q0" crlf)
)

(defrule transicion_q2_$
  ?estado_actual <-(estado q2)
  ?estados <-(estados $?otros_estados)
  ?simbolo_actual <-(caracter "$")
  ?estados_finales <-(estados_finales $?estados_finales_otros)
  ?cinta <-(entrada  ?siguiente  $?otros)
 =>
  (retract ?simbolo_actual)
  (retract ?estados)
  (retract ?cinta)
  (retract ?estado_actual)
  (assert (estado))
  (retract ?estados_finales)
  (assert (estados_finales $?estados_finales_otros q2))
  (assert (caracter ?siguiente))
  (assert (estados $?otros_estados))
  (assert (entrada $?otros "$"))
  (printout t "q2$" crlf)
  (printout t $?otros_estados crlf)
  (printout t "Accept q2" crlf)
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

(defrule final_state_q0
	?estado_actual <-(estado q0)
	?estados <- (estados $?otros)
	?simbolo_actual <-(caracter "$")
	?estados_finales <-(estados_finales $?final_states)
	?cinta <-(entrada)
=>
  (retract ?estados)
	(retract ?simbolo_actual)
	(retract ?estados_finales)
	(assert (estados_finales $?final_states q0))
	(printout t "final states" $?final_states "q0" crlf)
)

(defrule final_state_q2
	?estado_actual <-(estado q2)
	?estados <- (estados $?otros)
	?simbolo_actual <-(caracter "$")
	?estados_finales <-(estados_finales $?final_states)
	?cinta <-(entrada)
=>
  (retract ?estados)
	(retract ?simbolo_actual)
	(retract ?estados_finales)
	(assert (estados_finales $?final_states q2))
	(printout t "final states" $?final_states "q2" crlf)
)

(defrule not_final_state_q1
	?estado_actual <-(estado q1)
	?estados <- (estados)
	?estados_finales <-(estados_finales $?final_states)
=>
	(printout t "final states" $?final_states crlf)
)


(defrule q_fallido_0
  ?estado_actual <-(estado qfallido)
  ?simbolo_actual <-(caracter "0")
  ?estados <-(estados ?siguiente_estado $?otros_estados)
  ?cinta <-(entrada ?siguiente_simbolo $?otros)
 =>
  (retract ?estado_actual)
  (retract ?estados)
  (retract ?simbolo_actual)
  (retract ?cinta)
  (assert (estado ?siguiente_estado))
  (assert (estados $?otros_estados))
  (assert (caracter ?siguiente_simbolo))
  (assert (entrada $?otros))
)

(defrule q_fallido_1
  ?estado_actual <-(estado qfallido)
  ?simbolo_actual <-(caracter "1")
  ?cinta <-(entrada ?siguiente_simbolo $?otros)
 =>
  (retract ?simbolo_actual)
  (retract ?cinta)
  (assert (caracter ?siguiente_simbolo))
  (assert (entrada $?otros))
)


; asserts de prueba
; (assert (estado q0))
; (assert (estados_finales ))
; (assert (estados ))
; (assert (caracter "0" ))
; (assert (entrada "1" "1" "0" "0" "1" "$" ))
