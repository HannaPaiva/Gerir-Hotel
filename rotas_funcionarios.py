from flask import Flask, render_template, request, redirect, url_for, Blueprint
from programa.HP_Cliente import *
from programa.z_database_manager import DatabaseManager
app = Flask(__name__, static_folder='assets', static_url_path='/assets')
rotas_funcionario = Blueprint("rotas_funcionario", __name__)
conn= DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel")

@rotas_funcionario.route('/funcionarios')
def listar_funcionarios():
    # dados = listar("funcionario")
    dados = conn.select_data("funcionario")
    print(dados)
    if dados is not None:
        return render_template('funcionarios.html', dados=dados)
    else:
        return render_template('funcionarios.html')

@rotas_funcionario.route('/criar-funcionario', methods=['GET', 'POST'])
def criar_funcionario():
    
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
    conn.insert_data("funcionario", dados)
    return redirect(url_for('rotas_funcionario.listar_funcionarios'))

@rotas_funcionario.route('/editar-funcionario', methods=['GET', 'POST'])
def editar_funcionario():
    dados = {
        "idfuncionario": request.form["idfuncionario"],
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
    atualizar("funcionario", list(dados.keys()), dados, "idfuncionario", dados["idfuncionario"] )
    return redirect(url_for('rotas_funcionario.listar_funcionarios'))

@rotas_funcionario.route('/apagar-funcionario', methods=['GET', 'POST'])
def apagar_funcionario():
    dados = {
        "idfuncionario": request.form["idfuncionario"]
    }
    apagar("funcionario", "idfuncionario", dados["idfuncionario"])
    return redirect(url_for('rotas_funcionario.listar_funcionarios'))

app.register_blueprint(rotas_funcionario)

if __name__ == '__main__':
    app.run(debug=True)