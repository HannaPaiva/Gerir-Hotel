'''Classe de Cliente'''
class Cliente:
    def __init__(self, idCliente, primeiroNome, nomeDoMeio, ultimoNome, contribuinte, CC, email, telefone, dataNascimento, ativo):
        # self.clientes = []

        self.idCliente = idCliente          
        self.primeiroNome = primeiroNome       
        self.nomeDoMeio = nomeDoMeio
        self.ultimoNome = ultimoNome
        self.contribuinte = contribuinte
        self.CC = CC
        self.email = email
        self.telefone = telefone
        self.dataNascimento = dataNascimento
        self.ativo = ativo
   

    def criar(self):
      
        novo_cliente = {"nome": nome, "email": email}
        self.clientes.append(novo_cliente)
        print("Cliente criado com sucesso!")

    def pesquisar(self, termo):
        resultados = [cliente for cliente in self.clientes if termo.lower() in cliente['nome'].lower() or termo.lower() in cliente['email'].lower()]
        return resultados

    def listar(self):
        if not self.clientes:
            print("Nenhum cliente cadastrado.")
        else:
            for i, cliente in enumerate(self.clientes, 1):
                print(f"{i}. Nome: {cliente['nome']}, Email: {cliente['email']}")

    def alterar(self, indice, novo_nome, novo_email):
        if 0 <= indice < len(self.clientes):
            self.clientes[indice]["nome"] = novo_nome
            self.clientes[indice]["email"] = novo_email
            print("Cliente alterado com sucesso!")
        else:
            print("Índice inválido.")

    def apagar(self, indice):
        if 0 <= indice < len(self.clientes):
            cliente_removido = self.clientes.pop(indice)
            print(f"Cliente removido: {cliente_removido}")
        else:
            print("Índice inválido.")


# Exemplo de uso:
crud_clientes = ClienteCRUD()

crud_clientes.criar("João", "joao@email.com")
crud_clientes.criar("Maria", "maria@email.com")
crud_clientes.criar("Carlos", "carlos@email.com")

crud_clientes.listar()

resultado_pesquisa = crud_clientes.pesquisar("jo")
print("Resultados da pesquisa:")
print(resultado_pesquisa)

crud_clientes.alterar(1, "João da Silva", "novojoao@email.com")
crud_clientes.listar()

crud_clientes.apagar(2)
crud_clientes.listar()
