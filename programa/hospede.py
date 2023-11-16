import mysql.connector  

class Hospede():
    def __init__(self, idHospede, primeiroNome, nomeDoMeio, ultimoNome, cc, email, telefone, dataNascimento, ativo):
        self.idHospede = idHospede
        self.primeiroNome = primeiroNome
        self.nomeDoMeio = nomeDoMeio
        self.ultimoNome = ultimoNome
        self.cc = cc
        self.email = email
        self.telefone = telefone
        self.dataNascimento = dataNascimento
        self.ativo = ativo

    @property
    def idHospede(self):
        return self.__idHospede
    
    @idHospede.setter
    def idHospede(self, idHospede):


        
if __name__ == "__main__":
    Hospede = Hospede(id= 