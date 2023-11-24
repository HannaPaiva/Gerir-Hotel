from sqlalchemy import create_engine, MetaData, Table, text
from Z_dbconfig import *


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
 




if __name__ == "__main__":
    
    SELECT("cliente", "SELECT * FROM cliente")
