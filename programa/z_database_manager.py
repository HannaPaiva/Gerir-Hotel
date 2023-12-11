import mysql.connector
import datetime

class DatabaseManager:
    def __init__(self, host, user, password, database, port=3306):
        try:
            self.conn = mysql.connector.connect(host=host,
                                                user=user,
                                                password=password,
                                                database=database,
                                                port=port)
            self.cursor = self.conn.cursor(dictionary=True)
            print(f"LOG {datetime.datetime.now()}: Conexão à base de dados bem sucedida!")
            self.conn.close()
        except:
            print(f"LOG {datetime.datetime.now()}: Erro! Não foi possível estabelecer conexão à base de dados...")
            raise
    
    @staticmethod
    def get_columns(table):
        table = table.lower()

        columns = {
            "agencia": ["idagencia", "nomeagencia", "contatogeral", "nomerepresentante", "telefonerepresentante", "comissaoagencia"],
            "agenciametodo": ["idagencia", "idmetodo"],
            "cliente": ["idcliente", "primeironome", "nomedomeio", "ultimonome", "contribuinte", "cc", "email", "telefone", "datanascimento", "ativo"],
            "departamento": ["iddepartamento", "idchefe", "nomedepartamento", "descricao"],
            "funcionario": ["idfuncionario", "iddepartamento", "primeironome", "nomedomeio", "ultimonome", "contribuinte", "cc", "email", "telefone", "datanascimento", "endereco", "salario", "dataentrada", "datasaida", "status"],
            "hospede": ["idhospede", "primeironome", "nomedomeio", "ultimonome", "cc", "email", "telefone", "datanascimento", "ativo"],
            "metodoreserva": ["idmetodo", "nomemetodo"],
            "pagamento": ["idpagamento", "valortotal", "metodopagamento", "tarifareembolsavel", "datapagamento", "observacoes", "status", "idreserva"],
            "preco": ["idtarifa", "idreserva", "precomanual"],
            "quarto": ["idquarto", "numquarto", "descricao", "andar", "tipologia", "qtdcamacasal", "qtdcamasolteiro", "ativo", "estadisponivel"],
            "reserva": ["idreserva", "idcliente", "dataentrada", "datasaida", "numadultos", "numcriancas", "numbebes", "observacoes", "tipologiacontratada", "idagencia", "idmetodo"],
            "reservahospede": ["idquarto", "idreserva", "idhospede"],
            "reservaquarto": ["idquarto", "idreserva", "observacoes"],
            "servico": ["idservico", "nomeservico", "preco", "descricao", "iddepartamento"],
            "servicoprestado": ["idreserva", "idservico", "detalhes", "datahora", "idfuncionario", "iddepartamento"],
            "tarifa": ["idtarifa", "datainicio", "datafim", "preconoiteadulto", "preconoitecrianca", "tipologia"]
        }
        return columns.get(table, [])

    def insert_data(self, table:str, data:dict):
        self.conn.connect()
        query = f"INSERT INTO {table} "
        columns = []
        values = []
        for item in data:
            columns.append(str(item))
            values.append(data[item])
        query += f"({', '.join(columns)}) "
        valueString = "\nVALUES ("
        for value in values:
            if isinstance(value, str):
                valueString += f'"{value}", '
            else:
                valueString += f"{value}, "
        valueString = valueString[:-2] + ")"
        query += valueString
        try:
            self.cursor.execute(query)
            self.conn.commit()
            self.conn.disconnect()
        except:
            print(f"LOG {datetime.datetime.now()}: Erro! Não foi possível inserir os dados na base de dados...")
            raise

    def select_data(self, table:str, tableColumns:list=[], searchColumn:str="", join:list=[{"table": "", "columns": [], "with": "", "on": "" }], orderBY:str="", search:str="", limit:int=0, page=1):
        self.conn.connect()
        # FINAL QUERY WHERE EVERYTHING WILL BE APPENDED
        query = "SELECT "

        # COLUMNS
        if tableColumns == []:
            tableColumns = DatabaseManager.get_columns(table)

        for joinData in join:
            if joinData["columns"] == []:
                joinData["columns"] = DatabaseManager.get_columns(joinData["table"])
        
        columnsList = []
        for column in tableColumns:
            columnsList.append(f"{table}.{column}")
        for joinData in join:
            for column in joinData["columns"]:
                columnsList.append(f"{joinData['table']}.{column}")
        columns = ", ".join(columnsList) + ""
        query += columns
        
        # FROM
        query += f"\nFROM {table}"
        
        # INNER JOIN
        if join != [{"table": "", "columns": [], "with": "", "on": "" }]:
            joinString = ""
            for joinData in join:
                joinString += f"\nINNER JOIN {joinData['table']}\n\tON {joinData['with']}.{joinData['on']} = {joinData['table']}.{joinData['on']}"
            query += joinString
        
        # WHERE
        if search != "":
            where = "\nWHERE "
            conditions = []
            if searchColumn == "":
                for column in columnsList:
                    conditions.append(f'{column} LIKE "{search}"')
            else:
                conditions.append(f'{table}.{searchColumn} LIKE "{search}"')            
            where += " OR ".join(conditions)
            query += where
            
        # ORDER BY
        if orderBY != "":
            query += f"\nORDER BY {table}.{orderBY}"

        # LIMIT
        if limit != 0:

            # PAGE
            query += f"\nLIMIT {limit}"
            query += f"\nOFFSET {limit * (page-1)}"

        try:
            self.cursor.execute(query)
            result = self.cursor.fetchall()
            self.conn.disconnect()
            return result
        except:
            print(f"LOG {datetime.datetime.now()}: Erro! Não foi possível recolher os dados...")
            raise
        
    def delete_data(self, table:str, idDict:dict):
        self.conn.connect()
        query = f"DELETE FROM {table}"
        conditions = []
        
        for key in idDict:
            conditions.append(f"{key} = {idDict[key]}")
        query += "\nWHERE " + " AND ".join(conditions)

        try:
            self.cursor.execute(query)
            self.conn.commit()
            self.conn.disconnect()
        except:
            print(f"LOG {datetime.datetime.now()}: Erro! Não foi possível apagar os dados...")

    def update_data(self, table:str, data:dict, idDict:dict):
        self.conn.connect()
        query = f"UPDATE {table}"
        
        changes = []
        for key in data:
            if isinstance(data[key], str):
                data[key] = f'"{data[key]}"'
            changes.append(f"{key} = {data[key]}")
        query += "\nSET " + ", ".join(changes)
        
        conditions = []
        for key in idDict:
            conditions.append(f"{key} = {idDict[key]}")
        query += f"\nWHERE " + " AND ".join(conditions)

        try:
            self.cursor.execute(query)
            self.conn.commit()
            self.conn.disconnect()
        except:
            print(f"LOG {datetime.datetime.now()}: Erro! Não foi possível atualizar os dados...")
            raise
    
    def close(self):
        try:
            self.conn.close()
            print(f"LOG {datetime.datetime.now()}: Disconectado da base de dados!")
        except:
            print(f"LOG {datetime.datetime.now()}: Erro! Não foi possível fechar a conexão à base de dados...")
            raise

    def connect(self):
        try:
            self.conn.connect()
            print(f"LOG {datetime.datetime.now()}: Conexão à base de dados bem sucedida!")
        except:
            print(f"LOG {datetime.datetime.now()}: Erro! Não foi possível estabelecer conexão à base de dados...")
            raise

if __name__ == "__main__":
    conn = DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel")
    update = conn.update_data("funcionario", {"key": "value", "key2": "value2"}, {"idfuncionario": 1})
    # del(connection)