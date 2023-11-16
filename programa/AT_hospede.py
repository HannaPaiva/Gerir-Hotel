import mysql.connector
from AT_menu import Menu
from Z_funcoes import *
class Hospede(Menu):
    def __init__(self, primeiroNome:str, nomeDoMeio:str, ultimoNome:str, cc:str, email:str, telefone:str, dataNascimento:str, ativo:int):
        self.primeiroNome = primeiroNome
        self.nomeDoMeio = nomeDoMeio
        self.ultimoNome = ultimoNome
        self.cc = cc
        self.email = email
        self.telefone = telefone
        self.dataNascimento = dataNascimento
        self.ativo = ativo

    @property
    def primeiroNome(self):
        return self.__primeiroNome

    @primeiroNome.setter
    def primeiroNome(self, primeiroNome):
        if isinstance(primeiroNome, str) and len(primeiroNome) <= 60:
            self.__primeiroNome = primeiroNome

    @property
    def nomeDoMeio(self):
        return self.__nomeDoMeio

    @nomeDoMeio.setter
    def nomeDoMeio(self, nomeDoMeio):
        if isinstance(nomeDoMeio, str) and len(nomeDoMeio) <= 60:
            self.__nomeDoMeio = nomeDoMeio
        else:
            raise

    @property
    def ultimoNome(self):
        return self.__ultimoNome

    @ultimoNome.setter
    def ultimoNome(self, ultimoNome):
        if isinstance(ultimoNome, str) and len(ultimoNome) <= 45:
            self.__ultimoNome = ultimoNome
        else:
            raise

    @property
    def cc(self):
        return self.__cc

    @cc.setter
    def cc(self, cc):
        if isinstance(cc, str) and len(cc) <= 45:
            self.__cc = cc
        else:
            raise

    @property
    def email(self):
        return self.__email

    @email.setter
    def email(self, email):
        if isinstance(email, str) and len(email) <= 45 and "@" in email:
            self.__email = email
        else:
            raise
        
    @property
    def telefone(self):
        return self.__telefone

    @telefone.setter
    def telefone(self, telefone):
        if isinstance(telefone, str) and len(telefone) <= 45:
            self.__telefone = telefone  
        else:
            raise

    @property
    def dataNascimento(self):
        return self.__dataNascimento

    @dataNascimento.setter
    def dataNascimento(self, dataNascimento):
        if checkDate(dataNascimento):
            self.__dataNascimento = dataNascimento
        else:
            raise
    
    @property
    def ativo(self):
        return self.__ativo
    
    @ativo.setter
    def ativo(self, ativo):
        if isinstance(ativo, int):
            if ativo:
                self.__ativo = 1
            else:
                self.__ativo = 0
        else:
            raise

    def criar():
        pass

    def pesquisar():
        pass
    
    def info():
        pass

    def alterar():
        pass
    
    def apagar():
        pass
    
if __name__ == "__main__":
    newHospede = Hospede()