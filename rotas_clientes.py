from flask import Flask, render_template, request, redirect, url_for, Blueprint
from programa.HP_Cliente import *

app = Flask(__name__, static_folder='assets', static_url_path='/assets')
rotas_cliente = Blueprint("rotas_cliente", __name__)

@rotas_cliente.route('/clientes')
def listar_clientes():
    dados = listar("cliente")

    dados_empty = {
        "primeiroNome":"",
        "nomeDoMeio": "",
        "ultimoNome": "",
        "contribuinte": "",
        "CC": "",
        "email": "",
        "telefone":"",
        "dataNascimento": "",
        "ativo": "",
        "genero": "",
    }

    if dados is not None:
        return render_template('clientes.html', dados=dados)
    else:
        return render_template('clientes.html')

@rotas_cliente.route('/criar-cliente', methods=['GET', 'POST'])
def criar_cliente():
    dados = {
        "primeiroNome": request.form["primeiroNome"],
        "nomeDoMeio": request.form["nomeDoMeio"],
        "ultimoNome": request.form["ultimoNome"],
        "contribuinte": request.form["contribuinte"],
        "CC": request.form["CC"],
        "email": request.form["email"],
        "telefone": request.form["telefone"],
        "dataNascimento": request.form["dataNascimento"],
        "ativo": request.form["ativo"],
        "genero": request.form["genero"],
    }
    inserir("cliente", list(dados.keys()), dados)
    return redirect(url_for('rotas_cliente.listar_clientes'))

@rotas_cliente.route('/editar-cliente', methods=['GET', 'POST'])
def editar_cliente():
    dados = {
        "idCliente": request.form["idCliente"],
        "primeiroNome": request.form["primeiroNome"],
        "nomeDoMeio": request.form["nomeDoMeio"],
        "ultimoNome": request.form["ultimoNome"],
        "contribuinte": request.form["contribuinte"],
        "CC": request.form["CC"],
        "email": request.form["email"],
        "telefone": request.form["telefone"],
        "dataNascimento": request.form["dataNascimento"],
        "ativo": request.form["ativo"],
        "genero": request.form["genero"],
    }
    atualizar("cliente", list(dados.keys()), dados, "idCliente", dados["idCliente"] )
    return redirect(url_for('rotas_cliente.listar_clientes'))

@rotas_cliente.route('/apagar-cliente', methods=['GET', 'POST'])
def apagar_cliente():
    dados = {
        "idCliente": request.form["idCliente"]
    }
    apagar("cliente", "idCliente", dados["idCliente"])
    return redirect(url_for('rotas_cliente.listar_clientes'))

app.register_blueprint(rotas_cliente)

if __name__ == '__main__':
    app.run(debug=True)
