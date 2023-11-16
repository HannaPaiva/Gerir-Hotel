from sqlalchemy import create_engine, MetaData, Table

user = 'root'
password = '' 
host = 'localhost'
porta = '3306'  
bd = 'Hotel'


conn= f"mysql+pymysql://{user}:{password}@{host}:{porta}/{bd}"

engine = create_engine(conn, echo=True)  

# Criar um objeto MetaData
meta = MetaData()