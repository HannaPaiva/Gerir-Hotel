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

def visualizar(tabela, campos=None, condicoes=None, joins=None):
    conexao = engine.connect()
    metadata = MetaData()
    campos_query = ",".join(campos)
    print ("++++++++++++++")
   
    # Define a tabela alvo
    target_table = Table(tabela, metadata, autoload_with=engine)

    # Usa o método select para criar a expressão de seleção
    query = select(Column(campos_query) or [target_table])

    # Adiciona a tabela alvo à consulta
    query = query.select_from(target_table)

    # Adiciona condições à consulta, se houver
    if condicoes:
        query = query.where(condicoes)

    # Adiciona joins à consulta, se houver
    if joins:
        for join_table, on_condition in joins:
            query = query.join(join_table, on_condition)

    # Executa a consulta
    result = conexao.execute(query).fetchall()

    # Fecha a conexão
    conexao.close()

    return result

def main():
    conectar_bd()

    # Exemplo de visualização da tabela 'teste' com condição de busca
    condicoes = text("aa = aa")
    resultado = visualizar("teste", campos=["aa", "bb"], condicoes=condicoes, joins=[("outra_tabela", "cliente.idCliente = teste.aa")])

    print(resultado)

if __name__ == "__main__":
    main()
