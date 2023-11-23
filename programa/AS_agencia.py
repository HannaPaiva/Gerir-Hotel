from AT_menu import Menu

class Agencia(Menu):
    def __init__(self, idAgencia, nomeAgencia, contatoGeral, nomeRepresentante,  telefoneRepresentante, comissaoAgencia):
        self.idAgencia = idAgencia
        self.nome = nomeAgencia
        self.contato = contatoGeral
        self.nomeRepresentante = nomeRepresentante
        self.telefoneRepresentante = telefoneRepresentante
        self.comissaoAgencia = comissaoAgencia
        self.agencias = []
    
    
    @property
    def idAgencia(self):
        return self.__idAgencia
    
    @idAgencia.setter
    def idAgencia(self, idAgencia):
        print("debug: setting idAgencia")
        if int(idAgencia):
            self.__idAgencia = idAgencia
        else:
            raise
    
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
            self.__comissaoAgencia = comissaoAgencia
        else: 
            raise
    
    def criar(self , nomeAgencia, contatoGeral, nomeRepresentante,  telefoneRepresentante, comissaoAgencia ):
        agencias = {
            "idAgencia" : len(self.idAgencia) + 1,
            "nomeAgencia" : nomeAgencia,
            "contatoGeral" : contatoGeral,
            "nomeRepresentante" : nomeRepresentante,
            "telefoneRepresentante" : telefoneRepresentante,
            "comissaoAgencia" : comissaoAgencia
        }

    def pesquisar(self):
        pass

    def listar(self):
        print("Agencias:")
        for agencias in self.agencias:
            print(agencias)

    def alterar():
        pass

    def apagar():
        pass