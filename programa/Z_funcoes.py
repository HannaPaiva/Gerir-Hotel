
def checkDate(date):
    if isinstance(date, str):
        date = date.split("-")
        try:
            datetime.datetime(int(date[0]), int(date[1]), int(date[2]))
            return True
        except ValueError:
            return False
    else:
        return False



'''Conexões com a Base de Dados'''

    
def criar(self):
     pass

def pesquisar(self):
    pass   
    
def info(self):
    pass

def alterar(self):
    pass

def apagar(self):
    pass
    