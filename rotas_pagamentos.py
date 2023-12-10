from flask import Flask, render_template, request, redirect, url_for, Blueprint



from programa.HP_Cliente import *

app = Flask(__name__, static_folder='assets', static_url_path='/assets')
rotas_pagamento = Blueprint("rotas_pagamento", __name__)


@rotas_pagamento.route('/pagamentos')
def listar_pagamentos():
    dados = listar("pagamento")



    if dados is not None:
        return render_template('pagamentos.html', dados=dados)
    else:
        return render_template('pagamentos.html')

@rotas_pagamento.route('/criar-pagamento', methods=['GET', 'POST'])
def criar_pagamento():
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
    inserir("pagamento", list(dados.keys()), dados)
    return redirect(url_for('rotas_pagamento.listar_pagamentos'))

@rotas_pagamento.route('/editar-pagamento', methods=['GET', 'POST'])
def editar_pagamento():
    dados = {
        "idpagamento": request.form["idpagamento"],
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
    atualizar("pagamento", list(dados.keys()), dados, "idpagamento", dados["idpagamento"] )
    return redirect(url_for('rotas_pagamento.listar_pagamentos'))

@rotas_pagamento.route('/apagar-pagamento', methods=['GET', 'POST'])
def apagar_pagamento():
    dados = {
        "idpagamento": request.form["idpagamento"]
    }
    apagar("pagamento", "idpagamento", dados["idpagamento"])
    return redirect(url_for('rotas_pagamento.listar_pagamentos'))

app.register_blueprint(rotas_pagamento)

if __name__ == '__main__':
    app.run(debug=True)
