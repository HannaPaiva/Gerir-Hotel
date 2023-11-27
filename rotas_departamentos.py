from flask import Flask, render_template, request, redirect, url_for, Blueprint

from programa.HP_Cliente import *

app = Flask(__name__, static_folder='assets', static_url_path='/assets')
rotas_departamento = Blueprint("rotas_departamento", __name__)

@rotas_departamento.route('/departamentos')
def listar_departamentos():
    dados = listar("departamento")

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
        return render_template('departamentos.html', dados=dados)
    else:
        return render_template('departamentos.html')

@rotas_departamento.route('/criar-departamento', methods=['GET', 'POST'])
def criar_departamento():
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
    inserir("departamento", list(dados.keys()), dados)
    return redirect(url_for('rotas_departamento.listar_departamentos'))

@rotas_departamento.route('/editar-departamento', methods=['GET', 'POST'])
def editar_departamento():
    dados = {
        "iddepartamento": request.form["iddepartamento"],
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
    atualizar("departamento", list(dados.keys()), dados, "iddepartamento", dados["iddepartamento"] )
    return redirect(url_for('rotas_departamento.listar_departamentos'))

@rotas_departamento.route('/apagar-departamento', methods=['GET', 'POST'])
def apagar_departamento():
    dados = {
        "iddepartamento": request.form["iddepartamento"]
    }
    apagar("departamento", "iddepartamento", dados["iddepartamento"])
    return redirect(url_for('rotas_departamento.listar_departamentos'))

app.register_blueprint(rotas_departamento)

if __name__ == '__main__':
    app.run(debug=True)
