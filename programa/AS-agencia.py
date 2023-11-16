class Agencia():
    def __init__(self, idAgencia, nome, contato, nomeRepresentante,  telefoneRepresentante, comissaoAgencia):
        self.id = idAgencia
        self.nome = nome
        self.contato = contato
        self.nomeRepresentante = nomeRepresentante
        self.telefoneRepresentante = telefoneRepresentante
        self.comissaoAgencia = comissaoAgencia
    
    @property
    def id(self):
        return self.__id
    
    @id.setter
    def id(self, id):
        print("debug: set id")
        if int(id):
            self.__id = id
        else:
            raise