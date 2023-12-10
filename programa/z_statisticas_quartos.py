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





def listar_total_rooms():
    conexao = conectar()
    if conexao:
        try:
            cursor = conexao.cursor()

            custom_query = "SELECT COUNT(*) FROM quarto"
            cursor.execute(custom_query)

            total_rooms = cursor.fetchone()[0]

            return total_rooms
        except Exception as e:
            print(f"Erro ao executar a consulta: {e}")
        finally:
            if conexao.is_connected():
                cursor.close()
                conexao.close()

def quartos_ocupados():
    conexao = conectar()
    if conexao:
        try:
            cursor = conexao.cursor()

            custom_query = "SELECT COUNT(*) FROM quarto WHERE estaDisponivel = 0"
            cursor.execute(custom_query)

            occupied_rooms = cursor.fetchone()[0]

            return occupied_rooms
        except Exception as e:
            print(f"Erro ao executar a consulta: {e}")
        finally:
            if conexao.is_connected():
                cursor.close()
                conexao.close()

def quartos_disponiveis():
    conexao = conectar()
    if conexao:
        try:
            cursor = conexao.cursor()

            custom_query = "SELECT COUNT(*) FROM quarto WHERE estaDisponivel = 1"
            cursor.execute(custom_query)

            occupied_rooms = cursor.fetchone()[0]

            return occupied_rooms
        except Exception as e:
            print(f"Erro ao executar a consulta: {e}")
        finally:
            if conexao.is_connected():
                cursor.close()
                conexao.close()

def main():
    total_rooms = listar_total_rooms()
    occupied_rooms = quartos_ocupados()
    available_rooms = quartos_disponiveis()

    print(f"Total number of rooms: {total_rooms}")
    print(f"Number of occupied rooms: {occupied_rooms}")
    print(f"Total number of rooms: {available_rooms}")

if __name__ == "__main__":
    main()
