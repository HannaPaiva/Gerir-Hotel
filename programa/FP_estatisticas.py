import mysql.connector


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
        
            return conexao
    except Exception as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
        return None

def receita(data_inicio, data_fim):
    conexao = conectar()
    if conexao:
        try:
            cursor = conexao.cursor()

            custom_query = f"SELECT SUM(p.valorTotal) AS receitaGerada From pagamento p WHERE p.dataPagamento BETWEEN '{data_inicio}' AND '{data_fim}'"
            cursor.execute(custom_query)

            receita = cursor.fetchone()
            return receita
        except Exception as e:
            print (f"Erro ao executar a consulta: {e}")
        finally:
            if conexao.is_connected():
                cursor.close()
                conexao.close()


def contagem_servicos():
    conexao = conectar()
    if conexao:
        try:
            cursor = conexao.cursor()

            custom_query = "SELECT s.idServico, s.nomeServico, COUNT(sp.idServico) AS vezesRealizado FROM servico s LEFT JOIN servicoprestado sp ON s.idServico = sp.idServico GROUP BY s.idServico, s.nomeServico"
            cursor.execute(custom_query)

            servicos_prestados = cursor.fetchall()
            return servicos_prestados
        except Exception as e:
            print (f"Erro ao executar a consulta: {e}")
        finally:
            if conexao.is_connected():
                cursor.close()
                conexao.close()

def lealdadecliente():
    conexao = conectar()
    if conexao:
        try:
            cursor = conexao.cursor()

            custom_query = ""
            cursor.execute(custom_query)

            lealdade = cursor.fetchall()
            return lealdade
        except Exception as e:
            print (f"Erro ao executar a consulta: {e}")
        finally:
            if conexao.is_connected():
                cursor.close()
                conexao.close()