class Pagamentos():
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
    
    