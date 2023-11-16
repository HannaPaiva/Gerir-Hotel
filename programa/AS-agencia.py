class Agencia():
    def __init__(self, nomeAgencia, contatoGeral, nomeRepresentante,  telefoneRepresentante, comissaoAgencia):
        self.nome = nomeAgencia
        self.contato = contatoGeral
        self.nomeRepresentante = nomeRepresentante
        self.telefoneRepresentante = telefoneRepresentante
        self.comissaoAgencia = comissaoAgencia
    
    
    @property
    def nomeAgencia(self):
        return self.__nomeAgencia
    
    @nomeAgencia.setter
    def nomeAgencia(self, nomeAgencia):
        print("debug: setting name")
        if len(nomeAgencia) < 45:
            self.__nomeAgencia = nomeAgencia
    
    @property
    def contatoGeral(self):
        return self.__contatoGeral
    
    @contatoGeral.setter
    def contatoGeral(self, contatoGeral):
        print("debug: setting contato")
        if int(contatoGeral):
            self.__contatoGeral = contatoGeral
    
    @property
    def nomeRepresentante(self):
        return self.__nomeRepresentante
    
    @nomeRepresentante.setter
    def nomeRepresentate(self, nomeRepresentate):
        print("debug: setting nomeRep")
            
        
        
        