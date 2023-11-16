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
        else:
            raise
    
    @property
    def contatoGeral(self):
        return self.__contatoGeral
    
    @contatoGeral.setter
    def contatoGeral(self, contatoGeral):
        print("debug: setting contato")
        if int(contatoGeral):
            self.__contatoGeral = contatoGeral
        else:
            raise
    
    @property
    def nomeRepresentante(self):
        return self.__nomeRepresentante
    
    @nomeRepresentante.setter
    def nomeRepresentate(self, nomeRepresentante):
        print("debug: setting nomeRep")
        if len(nomeRepresentante) < 45:
            self.__nomeRepresentante = nomeRepresentante
        else:
            raise
    
    @property
    def telefoneRepresentante(self):
        return self.__telefoneRepresentante
    
    @telefoneRepresentante.setter
    def telefoneRepresentante(self, telefoneRepresentante):
        print("debug:setting telRepr")
        if int(telefoneRepresentante):
            self.__telefoneRepresentante = telefoneRepresentante
        else:
            raise
    
    @property
    def comissaoAgencia(self):
        return self.__comissaoAgencia
    
    @comissaoAgencia.setter
    def comissaoAgencia(self, comissaoAgencia):
        print("debug: setting comissaoAgencia")
        if float(comissaoAgencia):
            self.comissaoAgencia = comissaoAgencia
        else: 
            raise
        