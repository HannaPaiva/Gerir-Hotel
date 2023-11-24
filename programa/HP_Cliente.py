import mysql.connector

# Configurações do banco de dados
db_name = 'hotel'
db_user = 'root'
db_password = ''
db_host = 'localhost'

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

# Função para fazer select em uma tabela específica
def listar(tabela):
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

# Exemplo de uso
tabela_consulta = 'cliente'

