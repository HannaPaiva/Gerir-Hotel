from flask import Flask, render_template, request, redirect, url_for, Blueprint



from programa.HP_Cliente import *

app = Flask(__name__, static_folder='assets', static_url_path='/assets')
rotas_servico = Blueprint("rotas_servico", __name__)


@rotas_servico.route('/servicos')
def listar_servicos():
    dados = listar("servico")

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
        return render_template('servicos.html', dados=dados)
    else:
        return render_template('servicos.html')

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
    inserir("servico", list(dados.keys()), dados)
    return redirect(url_for('rotas_servico.listar_servicos'))

@rotas_servico.route('/editar-servico', methods=['GET', 'POST'])
def editar_servico():
    dados = {
        "idservico": request.form["idservico"],
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
    atualizar("servico", list(dados.keys()), dados, "idservico", dados["idservico"] )
    return redirect(url_for('rotas_servico.listar_servicos'))

@rotas_servico.route('/apagar-servico', methods=['GET', 'POST'])
def apagar_servico():
    dados = {
        "idservico": request.form["idservico"]
    }
    apagar("servico", "idservico", dados["idservico"])
    return redirect(url_for('rotas_servico.listar_servicos'))

app.register_blueprint(rotas_servico)

if __name__ == '__main__':
    app.run(debug=True)
