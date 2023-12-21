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



def free_select(query):
    conexao = conectar()
    if conexao:
        try:
            cursor = conexao.cursor(dictionary=True)
            cursor.execute(query)
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

            set_clause = ', '.join([f"{campo} = %s" for campo in campos])
            
            sql = f"UPDATE {tabela} SET {set_clause} WHERE {primarykey} = {id}"
            
            cursor.execute(sql, tuple(dados.values()))
            
            conexao.commit()
            
        except Exception as e:
            print(f"Erro ao executar a atualização: {e}")
        finally:
            if conexao.is_connected():
                cursor.close()
                conexao.close()


def apagar(tabela, primarykey, id):
    conexao = conectar()
    if conexao:
        try:
            cursor = conexao.cursor()
            
            # Construa a instrução SQL para deletar o registro
            sql = f"DELETE FROM {tabela} WHERE {primarykey} = {id}"
            
            # Execute a instrução SQL com o valor do ID a ser excluído
            cursor.execute(sql)
            
            # Commit para aplicar as alterações no banco de dados
            conexao.commit()
            
        except Exception as e:
            print(f"Erro ao executar a exclusão: {e}")
        finally:
            if conexao.is_connected():
                cursor.close()
                conexao.close()




def main():
    a = listar("funcionario")
    print(a)

if __name__ == "__main__":
    main()
