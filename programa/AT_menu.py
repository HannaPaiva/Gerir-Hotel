from abc import ABC, abstractclassmethod

class Menu(ABC):
    def __init__(self):
        pass
    
    @abstractclassmethod
    def criar(self):
        pass

    @abstractclassmethod
    def pesquisar(self):
        pass
    
    @abstractclassmethod
    def info(self):
        pass

    @abstractclassmethod
    def alterar(self):
        pass

    @abstractclassmethod
    def apagar(self):
        pass
    