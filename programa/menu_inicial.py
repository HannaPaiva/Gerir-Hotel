import os

def limpar_tela():
    if os.name == 'nt':
        os.system('cls')
    else:
        os.system('clear')

def exibir_menu():
    limpar_tela()
    print("Bem-vindo ao Sistema de Gerenciamento de Hotel")
    print()
    print("============================================")
    print()
    print(" 1. Nova Reserva")
    print(" 2. Vincular nova reserva")
    print(" 3. Vincular novo serviço")
    print(" 4. Verificar disponibilidade")
    print(" 5. Administração")
    print(" 6. Sair")
    print()
    print("============================================")

def nova_reserva():
    print("+- Nova Reserva -+")
    # Lógica para criar uma nova reserva
    input("Pressione Enter para continuar.")

def vincular_nova_reserva():
    print("+- Vincular Nova Reserva -+")
    # Lógica para vincular uma nova reserva
    input("Pressione Enter para continuar.")

def vincular_novo_servico():
    print("+- Vincular Novo Serviço -+")
    # Lógica para vincular um novo serviço
    input("Pressione Enter para continuar.")

def verificar_disponibilidade():
    print("+- Verificar Disponibilidade -+")
    # Lógica para verificar a disponibilidade
    input("Pressione Enter para continuar.")

def administracao():
    print("+- Administração -+")
    # Lógica para as tarefas de administração
    input("Pressione Enter para continuar.")

def main():
    while True:
        exibir_menu()
        
        escolha = input("Digite o número da opção desejada: ")

        match escolha:
            case '1':
                nova_reserva()
            case '2':
                vincular_nova_reserva()
            case '3':
                vincular_novo_servico()
            case '4':
                verificar_disponibilidade()
            case '5':
                administracao()
            case '6':
                print("Saindo do sistema. Até mais!")
                break
            case _:
                input("Opção inválida. Pressione Enter para tentar novamente.")

if __name__ == "__main__":
    main()
