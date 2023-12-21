from Z_funcoes import *
from AT_menu import Menu
from AS_agencia import Agencia
from programa.HP_functions import Cliente

class Reserva(Menu):
    def __init__ (self, idReserva, idCliente, dataEntrada, dataSaida, numAdultos, numCriancas, numBebes, observacoes, tipologiaContratada, idAgencia, placeidClienteer ):
        self.idReserva = idReserva
        self.idCliente = idCliente
        self.dataEntrada = dataEntrada
        self.dataSaida = dataSaida
        self.numAdultos = numAdultos
        self.numCriancas = numCriancas
        self.numBebes = numBebes
        self.observacoes = observacoes
        self.tipologiaContrada = tipologiaContratada
        self.idAgencia = idAgencia
        self.reservas = []

    @property
    def idReserva(self):
        return self.__idReserva
    
    @idReserva.setter
    def idReserva(self, idReserva):
        print ("debug: setting id da reserva.")
        if int(self, idReserva):
            self.__idReserva = idReserva
        else:
            raise

    @property
    def idCliente(self):
        return self.__idCliente
    
    @idCliente.setter
    def idCliente(self, idCliente):
        print ("debug: setting id do cliente.")
        if int(self, idCliente):
            self.__idCliente = idCliente
        else:
            raise
    
    @property
    def dataEntrada(self):
        return self.__dataEntrada
    
    @dataEntrada.setter
    def dataEntrada(self, dataEntrada):
        print ("debug: setting data de entrada.")
        if checkDate():
            self.__dataEntrada = dataEntrada
        else:
            raise
    
    @property
    def dataSaida(self):
        return self.__dataSaida
    
    @dataSaida.setter
    def dataSaida(self, dataSaida):
        print ("debug: setting data de saída.")
        if checkDate():
            self.__dataSaida = dataSaida
        else:
            raise
    
    @property
    def numAdultos(self):
        return self.__numAdultos
    
    @numAdultos.setter
    def numAdultos(self, numAdultos):
        print ("debug: setting número de adultos.")
        if (self, numAdultos) <= 4:
            self.__numAdultos = numAdultos
        else:
            raise
    
    @property
    def numCriancas(self):
        return self.__numCriancas
    
    @numCriancas.setter
    def numCriancas(self, numCriancas):
        print ("debug: setting número de crianças.")
        if (self, numCriancas) <= 4 :
            self.__numCriancas = numCriancas
        else:
            raise
    
    @property
    def numBebes(self):
        return self.__numBebes
    
    @numBebes.setter
    def numBebes(self, numBebes):
        print ("debug: setting número de bebés.")
        if (self, numBebes) <= 4 :
            self.__numBebes = numBebes
        else:
            raise
    
    @property
    def observacoes(self):
        return self.__observacoes
    
    @observacoes.setter
    def observacoes(self, observacoes):
        print ("debug: setting observações.")
        if str(self, observacoes):
            self.__observacoes = observacoes
        else:
            raise
    
    @property
    def tipologiaContratada(self):
        return self.__tipologiaContratada
    
    @tipologiaContratada.setter
    def tipologiaContratada(self, tipologiaContratada):
        print ("debug: setting tipologia contratada.")
        if len(self, tipologiaContratada) <= 45 :
            self.__tipologiaContratada = tipologiaContratada
        else:
            raise
    
    @property
    def idAgencias(self):
        return self.__idAgencias
    
    @idAgencias.setter
    def idAgencias(self, idAgencias):
        print ("debug: setting id da agência.")
        if isinstance(idAgencias, Agencia):
            self.__idAgencias = idAgencias
        else:
            raise