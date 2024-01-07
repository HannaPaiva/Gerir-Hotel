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

def inserir(tabela, dados):
    conexao = conectar()
    if conexao:
        try:
            cursor = conexao.cursor()
            campos_str = ', '.join(dados.keys())
            valores_str = ', '.join(['%s' for _ in dados.keys()])
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
    


def last_insert_id(cursor):
    try:
        cursor.execute("SELECT LAST_INSERT_ID()")
        result = cursor.fetchone()
        return result[0] if result else None
    except Exception as e:
        print(f"Erro ao obter o último ID inserido: {e}")
        return None


    
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


def chamar_procedimento(data_inicio, data_fim, preco_noite_adulto, preco_noite_crianca, num_quarto):
    conexao = conectar()
    if conexao:
        try:
            cursor = conexao.cursor()
            cursor.callproc('inserir_tarifas', (data_inicio, data_fim, preco_noite_adulto, preco_noite_crianca, num_quarto))
            conexao.commit()
        except Exception as e:
            print(f"Erro ao chamar o procedimento: {e}")
        finally:
            if conexao.is_connected():
                cursor.close()
                conexao.close()



def stored_procedure(procedimento, dados):
    conexao = conectar()
    
    if conexao:
        try:
            cursor = conexao.cursor()
            # Certifique-se de que a stored procedure tenha o mesmo número de parâmetros
            cursor.callproc(procedimento, dados)
            conexao.commit()
            
            # Captura o resultado da stored procedure
            result = list(cursor.stored_results())[0].fetchall()
            
            print("Stored procedure chamada com sucesso!")
            return {"status": result}
        except Exception as e:
            print(f"Erro ao chamar a stored procedure: {e}")
            return {"status": str(e)}
        finally:
            if conexao.is_connected():
                cursor.close()
                conexao.close()



def apagar_tarifas(data_inicio, data_fim, num_quarto):
    conexao = conectar()
    if conexao:
        try:
            cursor = conexao.cursor()
            cursor.callproc('apagar_tarifas', (data_inicio, data_fim, num_quarto))
            conexao.commit()
        except Exception as e:
            print(f"Erro ao chamar o procedimento: {e}")
        finally:
            if conexao.is_connected():
                cursor.close()
                conexao.close()


def dicionario(output):
    result = {}

    for key, valores in output.items():
        result[key] = valores[0][0] if valores else None

    return result

# Exemplo de uso:

def main():
    inserir_reserva = stored_procedure("InserirReserva", (1, '2024-12-23', '2024-12-26', 2, 1, 0, 'Reserva paAAAA', 't2', 1, 1, 1))
    

    status = dicionario({"status": inserir_reserva["status"]})

    print(status)

        


if __name__ == "__main__":
    main()
