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
        
            return conexao
    except Exception as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
        return None

def inserir(tabela, campos, dados):
    conexao = conectar()
    if conexao:
        try:
            cursor = conexao.cursor()
            campos_str = ', '.join(campos)
            valores_str = ', '.join(['%s' for _ in campos])
            sql = f"INSERT INTO {tabela} ({campos_str}) VALUES ({valores_str})"
            cursor.execute(sql, tuple(dados.values()))
            conexao.commit()
        except Exception as e:
            print(f"Erro ao executar a inserção: {e}")
        finally:
            if conexao.is_connected():
                cursor.close()
                conexao.close()
           

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
        
        
        
def atualizar(tabela, campos, dados, primarykey, id):
    conexao = conectar()
    if conexao:
        try:
            cursor = conexao.cursor()
            
            # Construa a parte SET da instrução SQL
            set_clause = ', '.join([f"{campo} = %s" for campo in campos])
            
            # Construa a instrução SQL completa
            sql = f"UPDATE {tabela} SET {set_clause} WHERE {primarykey} = {id}"
            
            # Execute a instrução SQL com os valores dos dados e a condição
            cursor.execute(sql, tuple(dados.values()))
            
            # Commit para aplicar as alterações no banco de dados
            conexao.commit()
            
        except Exception as e:
            print(f"Erro ao executar a atualização: {e}")
        finally:
            if conexao.is_connected():
                cursor.close()
                conexao.close()

def main():
    dados_para_inserir = {'aa': 'teste no segundo', 'bb': 'AAAAAAA'}
    tabela_consulta = 'teste'  # Substitua pelo nome da sua tabela

    # Insira os dados usando MySQL Connector
    inserir(tabela_consulta, list(dados_para_inserir.keys()), dados_para_inserir)

    # Liste os dados usando MySQL Connector
    resultado_mysql = listar(tabela_consulta)
    print("Listagem usando MySQL Connector:", resultado_mysql)

if __name__ == "__main__":
    main()
