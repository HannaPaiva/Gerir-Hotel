# Operações com a base de dados por parte do cliente
from sqlalchemy import create_engine, text, select, MetaData, Table, Column, Integer, String

db_name = 'hotel'
db_user = 'root'
db_password = ''
db_host = 'localhost'

# Conexão global
engine = None

def conectar_bd():
    global engine
    engine = create_engine(f'mysql+mysqlconnector://{db_user}:{db_password}@{db_host}/{db_name}')
    return engine

def inserir(tabela, campos, dados):
    conexao = engine.connect()

    sql = text(f"INSERT INTO {tabela} ({', '.join(campos)}) VALUES ({', '.join([':{}'.format(campo) for campo in campos])})")

    conexao.execute(sql, dados)
    conexao.commit()
    conexao.close()

def main():

    dados_para_inserir = {'aa': 'teste agr', 'bb': 'AAAAAAA'}

    conectar_bd()

    # Insira os dados
    inserir("teste", list(dados_para_inserir.keys()), dados_para_inserir)

if __name__ == "__main__":
    main()
