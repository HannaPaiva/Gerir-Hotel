import datetime
from Z_funcoes import *
class ServicoPrestado():
    def __init__(self, detalhes, dataHora):
        self.detalhes = detalhes
        self.dataHora = dataHora
        self.servicosPrestados = []
    
    @property
    def detalhes(self):
        return self.__detalhes
    
    @detalhes.setter
    def detalhes(self, detalhes):
        print ("debug: setting detalhes...")
        if str(detalhes):
            self.__detalhes = detalhes
        else:
            raise
    
    @property
    def dataHora(self):
        return self.__dataHora

    @dataHora.setter
    def dataHora(self, dataHora):
        print ("debug: setting data e hora")
        if checkDate():
            self.__dataHora = dataHora
        else:
            raise