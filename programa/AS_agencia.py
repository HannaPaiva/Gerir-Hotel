# from AT_menu import Menu

# class Agencia(Menu):
#     def __init__(self, idagencia, nomeagencia, contatogeral, nomerepresentante,  telefonerepresentante, comissaoagencia):
#         self.idagencia = idagencia
#         self.nomeagencia = nomeagencia
#         self.contatogeral = contatogeral
#         self.nomerepresentante = nomerepresentante
#         self.telefonerepresentante = telefonerepresentante
#         self.comissaoagencia = comissaoagencia
#         self.agencias = []
    
    
#     @property
#     def idagencia(self):
#         return self.__idagencia
    
#     @idagencia.setter
#     def idagencia(self, idagencia):
#         print("debug: setting idagencia")
#         if int(idagencia):
#             self.__idagencia = idagencia
#         else:
#             raise
    
#     @property
#     def nomeagencia(self):
#         return self.__nomeagencia
    
#     @nomeagencia.setter
#     def nomeagencia(self, nomeagencia):
#         print("debug: setting name")
#         if len(nomeagencia) < 45:
#             self.__nomeagencia = nomeagencia
#         else:
#             raise
    
#     @property
#     def contatogeral(self):
#         return self.__contatogeral
    
#     @contatogeral.setter
#     def contatogeral(self, contatogeral):
#         print("debug: setting contato")
#         if int(contatogeral):
#             self.__contatogeral = contatogeral
#         else:
#             raise
    
#     @property
#     def nomerepresentante(self):
#         return self.__nomerepresentante
    
#     @nomerepresentante.setter
#     def nomeRepresentate(self, nomerepresentante):
#         print("debug: setting nomeRep")
#         if len(nomerepresentante) < 45:
#             self.__nomerepresentante = nomerepresentante
#         else:
#             raise
    
#     @property
#     def telefonerepresentante(self):
#         return self.__telefonerepresentante
    
#     @telefonerepresentante.setter
#     def telefonerepresentante(self, telefonerepresentante):
#         print("debug:setting telRepr")
#         if int(telefonerepresentante):
#             self.__telefonerepresentante = telefonerepresentante
#         else:
#             raise
    
#     @property
#     def comissaoagencia(self):
#         return self.__comissaoagencia
    
#     @comissaoagencia.setter
#     def comissaoagencia(self, comissaoagencia):
#         print("debug: setting comissaoagencia")
#         if float(comissaoagencia):
#             self.__comissaoagencia = comissaoagencia
#         else: 
#             raise
    
#     def criar(self , idagencia, nomeagencia, contatogeral, nomerepresentante,  telefonerepresentante, comissaoagencia ):
#         agencias = {
#             "idagencia" : len(self.idagencia) + 1,
#             "nomeagencia" : nomeagencia,
#             "contatogeral" : contatogeral,
#             "nomerepresentante" : nomerepresentante,
#             "telefonerepresentante" : telefonerepresentante,
#             "comissaoagencia" : comissaoagencia
#         }

#     def pesquisar(self):
#         pass

#     def listar(self):
#         print("Agencias:")
#         for agencias in self.agencias:
#             print(agencias)

#     def alterar():
#         pass

#     def apagar():
#         pass