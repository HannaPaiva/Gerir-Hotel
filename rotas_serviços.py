from flask import Flask, render_template, request, redirect, url_for, Blueprint

from programa.z_database_manager import DatabaseManager

conn = DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel", port=3306)

app = Flask(__name__, static_folder='assets', static_url_path='/assets')
rotas_servico = Blueprint("rotas_servico", __name__)


@rotas_servico.route('/servico')
def listar_servico():
    dados = conn.select_data("servico")
    if dados is not None:
        return render_template('servico.html', dados=dados)
    else:
        return render_template('servico.html')

@rotas_servico.route('/criar-servico', methods=['GET', 'POST'])
def criar_servico():
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
    conn.insert_data("cliente", dados)
    return redirect(url_for('rotas_cliente.listar_clientes'))

@rotas_servico.route('/editar-servico', methods=['GET', 'POST'])
def editar_cliente():
    idcliente = {"idcliente": request.form["idcliente"]}
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
    conn.update_data("cliente", dados, idcliente)
    return redirect(url_for('rotas_cliente.listar_clientes'))

    