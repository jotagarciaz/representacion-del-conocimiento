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
    
    def clausula(self):
        '''
        clausula : negacion | ¬ negacion
        '''

        dot = Digraph(comment='FormulaDot',format='png')


        aux = list(self.tokens)
        print(aux)
        num_nodes = len(aux)

        dot.node('1',label="expr 1")
        """ 
            array donde se guardan las posiciones de los parentesis, y del nodo principal, para poder ubicar el resto de nodos
            si se lee abrir parentesis se añade al final un indice si se lee cerrar parentesis lo quita.

            Las consultas siempre se realizan en el ultimo elemento del array
        """
        aux_lparen = [1]
        aux_expre = [1]
        altura = [1]
        for i in range(0,num_nodes):
            # CONST tiene que crear dos nodos, el de valor y la expresión, el nodo del valor se conecta a la expr, y el nodo expr se conecta al padre
            # dentro baja dos niveles, vuelves al nivel superior
            if aux[i].type == 'CONST':
                expr = aux_expre[-1]+1
                dot.node('{0}'.format(i+2),label="expr {0}".format(expr))
                dot.node('const {0}'.format(i+2),label=aux[i].value) 
                aux_expre.append(expr)    
                dot.edge('const {0}'.format(i+2),'{0}'.format(aux_expre[-1]))
                dot.edge('{0}'.format(expr),'{0}'.format(aux_expre[-2]))
            
            # AND or OR tiene que crear un nodo valor, el nodo valor se conecta con el padre
            # dentro baja un nivel, al salir vuelves al nivel superior        
            if aux[i].type == 'AND' or aux[i].type == 'OR':
                aux_expre.pop()
                dot.node('op {0}'.format(i+2),label=aux[i].value)
                dot.edge('op {0}'.format(i+2),'{0}'.format(aux_expre[-1]))
            
            # NOT tiene que crear 3 nodos, un nodo valor y dos nodos expresiones, el nodo valor se conecta con el primer nodo de expresion, las expresiones se conectan con el padre
            # dentro baja dos y un nivel, al salir ha bajado dos niveles (se encuentra en la segunda expresion).
            if aux[i].type == 'NOT':
                altura = altura.append(altura[-1]+2)
                expr = aux_expre[-1]+1
                dot.node('{0}'.format(i+2),label="expr {0}".format(i+2))
                dot.node('not {0}'.format(i+2),label=aux[i].value)
                dot.node('not {0}'.format(i+2),label=aux[i].value)
                dot.edge('not {0}'.format(i+2),'{0}'.format(i+2))
                dot.edge('not {0}'.format(i+2),'{0}'.format(i+2))
                
            
            # LPAREN tiene que crear 3 nodos, un nodo valor y dos nodos expresiones, el nodo valor se conecta con el primer nodo de expresion, las expresiones se conectan con el padre
            # dentro baja dos y un nivel, al salir ha bajado dos niveles (se encuentra en la segunda expresion).
            if aux[i].type == 'LPAREN':
                altura = altura.append(altura[-1]+2)
                aux_lparen.append(i)
                dot.node('{0}'.format(i+2),label="expr {0}".format(i+2))
                dot.node('lparen {0}'.format(i+2),label=aux[i].value)
                dot.edge('lparen {0}'.format(i+2),'{0}'.format(i+2))
                
            
            # RPAREN tiene que crear dos nodos, el de valor y la expresión, el nodo del valor se conecta a la expr, y el nodo expr se conecta al padre
            # entra bajando un nivel, al salir vuelves al nivel en el que estabas
            if aux[i].type == 'RPAREN':
                altura = altura.pop()
                aux_lparen.pop()
                dot.node('{0}'.format(i+2),label="expr {0}".format(i+2))
                dot.node('rparen {0}'.format(i+2),label=aux[i].value)
                dot.edge('rparen {0}'.format(i+2),'{0}'.format(i+2))
                


        """for i in range(2,num_expre+2):
            dot.edge('{0}'.format(i),'1')"""
        
        dot.render(view=True)

e = FormulaDot()

#print(list(lista_tokens(master_pattern,'¬ x ∨ ¬(y ∧ x)' )))
print(e.parse('¬ x ∨ ¬(y ∧ x)',{'x':True , 'y':False}))


