from sqlalchemy import create_engine, MetaData, Table

# Configurações de conexão
user = 'root'
password = ''  # Se você não definiu uma senha, deixe em branco
host = 'localhost'
porta = '3306'  # Porta padrão do MySQL
bd = 'Hotel'

# Criar a string de conexão
conn= f"mysql+pymysql://{user}:{password}@{host}:{porta}/{bd}"

# Criar uma engine de conexão
engine = create_engine(conn, echo=True)  # Defina echo=True para ver as queries SQL geradas

# Criar um objeto MetaData
meta = MetaData()

# Definir a tabela 'clientes'
tabela_clientes = Table('cliente', meta, autoload_with=engine)

# Criar uma conexão
conexao = engine.connect()

# Realizar uma consulta simples
consulta = tabela_clientes.select()

# Executar a consulta e obter os resultados
resultados = conexao.execute(consulta).fetchall()

# Exibir os resultados
for resultado in resultados:
    print(resultado)

# Fechar a conexão
conexao.close()
