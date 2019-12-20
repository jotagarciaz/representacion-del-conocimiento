;(assert (trans q0 1 q1))
;(assert (trans q0 0 q0))
;(assert (trans q1 1 q2))
;(assert (trans q1 0 q0))
;(assert (trans q2 0 q0))
;(assert (trans q2 1 q0))
;(assert (final q2))

;problema esto solo cogerá una opción de todos los posibles finales con sus posibles transiciones.
;añadir el estado a lista de estados visitados
(defrule first_transition_backward
  ?estado <-(final ?estado_actual)
  ?trans <-(trans ?siguientes_estados ?simbolo_actual $?estado_actual)
  ?estados <-(estados $?otros_estados)
 =>
  (retract ?estado)
  (retract ?siguientes_estados)
  (retract ?simbolo_actual)
  (retract ?estado_actual)
  (retract ?otros_estados)
  (assert (estado ?siguientes_estados))
  (assert (estados $?otros_estados $?siguientes_estados ))
  (assert (entrada $?otros ?simbolo_actual))
)

;esto solo coge una de las posibles transiciones
;añadir el estado a lista de estados visitados
(defrule others_transitions_backward
  ?estado <-(estado ?estado_actual)
  ?trans <-(trans ?siguientes_estados ?simbolo_actual $?estado_actual)
  ?estados <-(estados $?otros_estados)
 =>
  (retract ?estado)
  (retract ?siguientes_estados)
  (retract ?simbolo_actual)
  (retract ?estado_actual)
  (retract ?otros_estados)
  (assert (estado ?siguientes_estados))
  (assert (estados $?otros_estados $?siguientes_estados ))
  (assert (entrada $?otros ?simbolo_actual))
)

;coger el estado anterior y pasarlo hacia delante guardando el caracter
(defrule initial_state_backward
  ?estado <-(estado q0)
  ?trans <-(trans ?estado_actual ?simbolo_actual $?siguientes_estados)
 =>
  (retract ?estado)
  (retract ?simbolo_actual)
  (retract ?siguientes_estados)
  (assert (cinta $?otros ?simbolo_actual))
  (assert (estado ?siguientes_estados))
)

;coger siguiente estado forward
(defrule transition_state_forward
  ?estado <-(estado ?estado_actual)
  ?trans <-(trans ?estado_actual ?simbolo_actual $?siguientes_estados)
 =>
  (retract ?estado)
  (retract ?simbolo_actual)
  (retract ?siguientes_estados)
  (assert (cinta $?otros ?simbolo_actual))
  (assert (estado ?siguientes_estados))
)

(defrule transition_state_forward
  ?estado <-(estado ?estado_actual)
  ?estado_final <-(final ?estado_actual)
 =>
  (retract ?estado)
  (retract ?simbolo_actual)
  (assert (cinta $?otros "$"))
  (printout t "palabra encontrada: " $?otros "$" crlf)
)

;falta la función que una vez recorrido todos los estados posibles si no se ha llegado a q0 se pare