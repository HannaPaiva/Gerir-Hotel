class Servico():
    def __init__(self, idServico, nomeDoservico, preco, descricao):
        self.id = idServico
        self.nome = nomeDoservico
        self.preco = preco
        self.descricao = descricao
        self.servicos = []

    @property
    def idServico(self):
        return self.__idServico
    
    @idServico.setter
    def idServico(self, idServico):
        print("debug: setting id...")
        if int(idServico):
            self.__idServico = idServico
        else:
            raise
    
    @property
    def nomeDoservico(self):
        return self.__nomeDoservico
    
    @nomeDoservico.setter
    def nomeDoServico(self, nomeDoservico):
        print ("debug: setting nome...")
        if len(nomeDoservico) < 45:
            self.__nomeDoservico = nomeDoservico
        else:
            raise
    
    @property
    def preco(self):
        return self.__preco
    
    @preco.setter
    def preco(self, preco):
        print ("debug: setting preço...")
        if float(preco):
            self.__preco = preco
        else:
            raise
    
    @property
    def descricao(self):
        return self.__descricao
    
    @descricao.setter
    def preco(self, descricao):
        print ("debug: setting descrição...")
        if str(descricao):
            self.__descricao = descricao
        else:
            raise


    def criar(self, nomedoservico, preco, descricao, iddepartamento):
        serviço = {
            "iddepartamento": len(self.serviços) + 1,
            "nomedoservico": nomedoservico,
            "preco": preco,
            "descricao": descricao,
            "iddepartamento": iddepartamento
        }
        self.servicos.append (serviço)
        print("Serviço adicionado.")

    def pesquisar(self, idservico, nomedoservico, preco, descricao, iddepartamento):
        pass

    def ler(self):
        print("Serviços:")
        for serviço in self.serviços:
            print(serviço)

def main():
    serviços_crud = Servico()

    while True:

        print("1: Criar Serviço")
        print("2: Atualizar Serviço")
        print("3: Ler Serviço")
        print("5: Sair")

        escolha = int(input("Insira o número da ação que deseja realizar "))

        if escolha == 1:
            nomedoservico = input("Insira o nome do serviço ")
            preco = float(input("Insira o preco do serviço "))
            descricao = input("Insira a descricao do serviço ")
            iddepartamento = input("Insira o id do departamento ")
            serviços_crud.criar_serviço(nomedoservico, preco, descricao, iddepartamento)
        elif escolha == 3:
            serviços_crud.ler_serviços() 
        elif escolha == 5:
            break
        else:
            print("Escolha inválida")


if __name__ == "__main__":
    main()
