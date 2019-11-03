import re
import collections
from functools import wraps, partial
from graphviz import Digraph

def debug_method(func= None, prefix = ''):
	if func is None:
		return partial(debug, prefix = prefix)
	else:
		msg = prefix + func.__name__
		@wraps(func)
		def wrapper(*args, **kwargs):
			print(msg)
			return func(*args,**kwargs)
		return wrapper

def debug_class(cls):
	for key, val in vars(cls).items():
		if callable(val):
			setattr(cls, key, debug_method(val))
		return cls

print("Evaluado el codigo")




separacion = 60

CONST     = r'(?P<CONST>[a-z][A-Z]*)'
NUM     = r'(?P<NUM>\d+)'
PLUS    = r'(?P<PLUS>\+)'
MINUS   = r'(?P<MINUS>-)'
OR    = r'(?P<OR>∨)'
AND   = r'(?P<AND>∧)'
NOT   = r'(?P<NOT>¬)'
TIMES   = r'(?P<TIMES>\*)'
DIVIDE  = r'(?P<DIVIDE>/)'
LPAREN  = r'(?P<LPAREN>\()'
RPAREN  = r'(?P<RPAREN>\))'
WS      = r'(?P<WS>\s+)'
VERDADERO  = r'(?P<VERDADERO>TRUE)'
FALSO  = r'(?P<FALSO>FALSE)'

master_pattern = re.compile('|'.join((CONST,NUM, PLUS, MINUS, OR, AND, NOT,
									  TIMES, DIVIDE, LPAREN, RPAREN, WS,
									  VERDADERO, FALSO)))
Token = collections.namedtuple('Token', ['type', 'value'])


def lista_tokens(pattern, text):
	scanner = pattern.scanner(text)
	for m in iter(scanner.match, None):
		token = Token(m.lastgroup, m.group())

		if token.type != 'WS':
			yield token






class FormulaBooleana:
	'''
	Pequeña implementación de un parser de formulaesiones booleanas.
	Implementation of a recursive descent parser.
	Aquí la asignacion es un diccionario con variables.
	'''

	def parse(self, text, asig):
		self.tokens = lista_tokens(master_pattern, text)
		self.current_token = None
		self.next_token = None
		self._avanza()
		self.asig = asig
		return self.formula()


	def _avanza(self):
		self.current_token, self.next_token = self.next_token, next(self.tokens, None)
	def _acepta(self, token_type):
		# if there is next token and token type matches
		if self.next_token and self.next_token.type == token_type:
			self._avanza()
			return True
		else:
			return False

	def _espera(self, token_type):
		if not self._acepta(token_type):
			raise SyntaxError('Expected ' + token_type)

	def formula(self):
		'''
		formula : conjuncion | conjuncion ∨ formula
		'''
		formula_value = self.conjuncion()
		if self._acepta('OR'):
			formula_value = formula_value | self.formula()
		return formula_value

	def conjuncion(self):
		'''
		conjuncion : clausula | clausula ∧ conjuncion
		'''

		conj_value = self.clausula()
		if self._acepta('AND'):
			conj_value = conj_value & self.conjuncion()
		return conj_value

	def clausula(self):
		'''
		clausula : CONST | (formula)

		'''
		# Si aparece un parentesis
		if self._acepta('LPAREN'):
			formula_value = self.formula()
			self._espera('RPAREN')
			return formula_value
		elif self._acepta('CONST'):
			return self.asig[self.current_token.value]

class FormulaGeneral(FormulaBooleana):
	'''
	Pequeña implementación de un parser de formulaesiones booleanas.
	Implementation of a recursive descent parser.
	Aquí la asignacion es un diccionario con variables.
	'''
	
	def clausula(self):
		'''
		clausula:  ¬ CONST | ¬ (formula)
		
		'''
		if self._acepta('LPAREN'):
			formula_value = self.formula()
			self._espera('RPAREN')
			conj_value = formula_value
		elif self._acepta('CONST'):
			conj_value =  self.asig[self.current_token.value]
		if self._acepta('NOT'):
			formula_value = self.formula()
			conj_value = formula_value
			conj_value = not conj_value
		return conj_value

class FormulaDot(FormulaBooleana):
	def parse(self, text, asig):
		self.tokens = lista_tokens(master_pattern, text)
		self.current_token = None
		self.next_token = None
		self.asig = asig
		return self.formula()
	
	def clausula(self):
		'''
		clausula : negacion | ¬ negacion
		'''

		dot = Digraph(comment='FormulaDot',format='png')


		aux = list(self.tokens)
		print(aux)
		num_nodes = len(aux)

		dot.node('expr 1',label="expr 1")
		padre = [1]

		for i in range(0,num_nodes):
			aux_index = i+2
			# CONST tiene que crear dos nodos, el de valor y la expresión, el nodo del valor se conecta a la expr, y el nodo expr se conecta al padre
			# dentro baja dos niveles, vuelves al nivel superior
			if aux[i].type == 'CONST':
				dot.node('expr {0}'.format(aux_index),label="expr {0}".format(padre[-1]+1))
				dot.node('const {0}'.format(aux_index),label=aux[i].value)
				dot.edge('const {0}'.format(aux_index),'expr {0}'.format(aux_index))
				dot.edge('expr {0}'.format(aux_index),'expr {0}'.format(padre[-1]))
			
			# AND or OR tiene que crear un nodo valor, el nodo valor se conecta con el padre
			# dentro baja un nivel, al salir vuelves al nivel superior        
			elif aux[i].type == 'AND' or aux[i].type == 'OR':
				dot.node('op {0}'.format(aux_index),label=aux[i].value)
				dot.edge('op {0}'.format(aux_index),'expr {0}'.format(padre[-1]))
			
			# NOT tiene que crear 3 nodos, un nodo valor y dos nodos expresiones, el nodo valor se conecta con el primer nodo de expresion, las expresiones se conectan con el padre
			# dentro baja dos y un nivel, al salir ha bajado dos niveles (se encuentra en la segunda expresion).
			elif aux[i].type == 'NOT':
				#altura = altura.append(altura[-1]+2)
				dot.node('superior {0}'.format(aux_index),label="expr {0}".format(padre[-1]+1))
				dot.node('expr {0}'.format(aux_index),label="expr {0}".format(padre[-1]+1))
				dot.node('not {0}'.format(aux_index),label=aux[i].value)
				dot.edge('not {0}'.format(aux_index),'superior {0}'.format(aux_index))
				dot.edge('expr {0}'.format(aux_index),'superior {0}'.format(aux_index))
				# el nodo superior se conecta con el padre anterior
				dot.edge('superior {0}'.format(aux_index),'expr {0}'.format(padre[-1]))
				padre.append(aux_index)
				
				
			
			# LPAREN tiene que crear 3 nodos, un nodo valor y dos nodos expresiones, el nodo valor se conecta con el primer nodo de expresion, las expresiones se conectan con el padre
			# dentro baja dos y un nivel, al salir ha bajado dos niveles (se encuentra en la segunda expresion).
			elif aux[i].type == 'LPAREN':
				#altura = altura.append(altura[-1]+2)
				dot.node('superior {0}'.format(aux_index),label="expr {0}".format(padre[-1]+1))
				dot.node('expr {0}'.format(aux_index),label="expr {0}".format(padre[-1]+1))
				dot.node('lparen {0}'.format(aux_index),label=aux[i].value)
				dot.edge('lparen {0}'.format(aux_index),'superior {0}'.format(aux_index))
				dot.edge('expr {0}'.format(aux_index),'superior {0}'.format(aux_index))
				# el nodo superior se conecta con el padre anterior
				dot.edge('superior {0}'.format(aux_index),'expr {0}'.format(padre[-1]))

				padre.append(aux_index)
			
			# RPAREN tiene que crear dos nodos, el de valor y la expresión, el nodo del valor se conecta a la expr, y el nodo expr se conecta al padre
			# entra bajando un nivel, al salir vuelves al nivel en el que estabas
			elif aux[i].type == 'RPAREN':
				#altura = altura.pop()
				padre.pop()
				dot.node('rparen {0}'.format(aux_index),label=aux[i].value)
				dot.edge('rparen {0}'.format(aux_index),'superior {0}'.format(padre[-1]))

				
				
				


		"""for i in range(2,num_expre+2):
			dot.edge('{0}'.format(i),'1')"""
		
		dot.render(view=True)

e = FormulaDot()

#print(list(lista_tokens(master_pattern,'¬ x ∨ ¬(y ∧ x)' )))
print(e.parse('¬ x ∨ ¬(y ∧ (x ∨ ¬ x))',{'x':True , 'y':False}))


