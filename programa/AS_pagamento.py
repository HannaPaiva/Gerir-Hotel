from Z_funcoes import *
from AT_menu import Menu
class Pagamentos(Menu):
    def __init__(self, valorTotal, metodoPagamento, tarifaReembolsavel, dataPagamento, observacoes, status):
        self.valorTotal = valorTotal
        self.metodoPagamento = metodoPagamento
        self.tarifaReembolsavel = tarifaReembolsavel
        self.dataPagamentos = dataPagamento
        self.observacoes = observacoes
        self.status = status
        
    @property
    def valorTotal(self):
        return self.__valorTotal
    
    @valorTotal.setter
    def valorTotal(self, valorTotal):
        if float(valorTotal):
            self.__valorTotal = valorTotal
        else:
            raise
    
    @property
    def metodoPagamento(self):
        return self.__metodoPagamento
    
    @metodoPagamento.setter
    def metodoPagamento(self, metodoPagamento):
        if isinstance(metodoPagamento , str) and len(metodoPagamento) < 45:
            self.__metodoPagamento = metodoPagamento
        else:
            raise
    
    @property
    def tarifaReembolsavel(self):
        return self.__tarifaReembolsavel
    
    @tarifaReembolsavel.setter
    def tarifaReembolsavel(self, tarifaReembolsavel):
        if isinstance(tarifaReembolsavel , int):
            if tarifaReembolsavel:
                self.__tarifaReembolsavel = 1
            else:
                self.__tarifaReembolsavel = 0
        else:
            raise
        
    @property
    def dataPagamento(self):
        return self.__dataPagamento
    
    @dataPagamento.setter
    def dataPagamento(self, dataPagamento):
        if checkDate(dataPagamento):
            self.__dataPagamento = dataPagamento
        else:
            raise
        
    @property
    def observacoes(self):
        return self.__observacoes
    
    @observacoes.setter
    def observacoes(self, observacoes):
        if isinstance(observacoes, str):
            self.observacoes = observacoes
        else:
            raise
    
    @property
    def status(self):
        return self.status
    
    @status.setter
    def status(self, status):
        if isinstance(status , int):
            if status:
                self.__status = 1
            else:
                self.__status = 0
        else:
            raise