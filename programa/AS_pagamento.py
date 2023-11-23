from Z_funcoes import *
from AT_menu import Menu

class Pagamentos(Menu):
    def __init__(self, valorTotal, metodoPagamento, tarifaReembolsavel, dataPagamento, observacoes, status):
        self.valorTotal = valorTotal
        self.metodoPagamento = metodoPagamento
        self.tarifaReembolsavel = tarifaReembolsavel
        self.dataPagamento = dataPagamento
        self.observacoes = observacoes
        self.status = status

    @property
    def valorTotal(self):
        return self.__valorTotal
    
    @valorTotal.setter
    def valorTotal(self, valorTotal):
        if isinstance(valorTotal, (int, float)):
            self.__valorTotal = valorTotal
        else:
            raise ValueError("valorTotal must be a number.")
    
    @property
    def metodoPagamento(self):
        return self.__metodoPagamento
    
    @metodoPagamento.setter
    def metodoPagamento(self, metodoPagamento):
        if isinstance(metodoPagamento, str) and len(metodoPagamento) < 45:
            self.__metodoPagamento = metodoPagamento
        else:
            raise ValueError("metodoPagamento must be a string with length less than 45.")
    
    @property
    def tarifaReembolsavel(self):
        return self.__tarifaReembolsavel
    
    @tarifaReembolsavel.setter
    def tarifaReembolsavel(self, tarifaReembolsavel):
        if isinstance(tarifaReembolsavel, int):
            self.__tarifaReembolsavel = 1 if tarifaReembolsavel else 0
        else:
            raise ValueError("tarifaReembolsavel must be an integer.")
        
    @property
    def dataPagamento(self):
        return self.__dataPagamento
    
    @dataPagamento.setter
    def dataPagamento(self, dataPagamento):
        if checkDate(dataPagamento):
            self.__dataPagamento = dataPagamento
        else:
            raise ValueError("Invalid date format for dataPagamento.")
        
    @property
    def observacoes(self):
        return self.__observacoes
    
    @observacoes.setter
    def observacoes(self, observacoes):
        if isinstance(observacoes, str):
            self.__observacoes = observacoes
        else:
            raise ValueError("observacoes must be a string.")
    
    @property
    def status(self):
        return self.__status
    
    @status.setter
    def status(self, status):
        if isinstance(status, int):
            self.__status = 1 if status else 0
        else:
            raise ValueError("status must be an integer.")
