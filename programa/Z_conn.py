from sqlalchemy import create_engine, MetaData, Table, text
from Z_dbconfig import *

# tabela_clientes = Table('cliente', meta, autoload_with=engine)

# # Criar uma conexão
# conexao = engine.connect()

# # Realizar uma consulta simples
# consulta = tabela_clientes.select()

# # Executar a consulta e obter os resultados
# resultados = conexao.execute(consulta).fetchall()

# # Exibir os resultados
# for resultado in resultados:
#     print(resultado)

# # Fechar a conexão
# conexao.close()



def SELECT(tabela, sql):

    tabelas = Table(tabela, meta, autoload_with=engine)
    conexao = engine.connect()
    # consulta = tabela.select()
    query = text(sql)

    resultados = conexao.execute(query).fetchall()
    for resultado in resultados:
         print(resultado)
    conexao.close()

    

      
def INSERT():
    pass
      
def UPDATE():
    pass
      
def DELETE():
    pass
      
var = input("Insira uma tabela para verificar: ")
 


SELECT("cliente", "SELECT * FROM cliente")

