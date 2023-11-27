from sqlalchemy import create_engine, text, select, MetaData, Table, Column, Integer, String
import mysql.connector

# Configurações do banco de dados
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

def listar(tabela):
    conexao = engine.connect()

    try:
        resultado = conexao.execute(select([Table(tabela, MetaData(), autoload_with=engine)]))
        return [dict(row) for row in resultado]
    except Exception as e:
        print(f"Erro ao executar a consulta: {e}")
    finally:
        conexao.close()

def conectar():
    try:
        conexao = mysql.connector.connect(
            host=db_host,
            user=db_user,
            password=db_password,
            database=db_name
        )
        if conexao.is_connected():
            print("Conectado ao banco de dados")
            return conexao
    except Exception as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
        return None

def listar_mysql(tabela):
    conexao = conectar()
    if conexao:
        try:
            cursor = conexao.cursor(dictionary=True)
            cursor.execute(f"SELECT * FROM {tabela}")
            resultado = cursor.fetchall()
            return resultado
        except Exception as e:
            print(f"Erro ao executar a consulta: {e}")
        finally:
            if conexao.is_connected():
                cursor.close()
                conexao.close()
                print("Conexão encerrada")

def main():
    dados_para_inserir = {'aa': 'teste no terceiro', 'bb': 'AAAAAAA'}
    tabela_consulta = 'cliente'

    conectar_bd()

    # Insira os dados usando SQLAlchemy
    inserir("teste", list(dados_para_inserir.keys()), dados_para_inserir)

    # Liste os dados usando SQLAlchemy
    resultado_sqlalchemy = listar("teste")
    print("Listagem usando SQLAlchemy:", resultado_sqlalchemy)

    # Liste os dados usando MySQL Connector
    resultado_mysql = listar_mysql(tabela_consulta)
    print("Listagem usando MySQL Connector:", resultado_mysql)

if __name__ == "__main__":
    main()
