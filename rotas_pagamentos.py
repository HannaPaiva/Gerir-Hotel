from flask import Flask, render_template, request, redirect, url_for, Blueprint

from programa.z_database_manager import DatabaseManager
conn = DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel", port=3306)
app = Flask(__name__, static_folder='assets', static_url_path='/assets')
rotas_pagamento = Blueprint("rotas_pagamento", __name__)



@rotas_pagamento.route('/pagamentos')
def listar_pagamentos():
    dados = conn.select_data("pagamento")
    action = "pesquisar-pagamento"
    if dados is not None:
        return render_template('pagamentos.html', dados=dados, action = action)
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
    conn.insert_data("pagamento", dados)
    return redirect(url_for('rotas_pagamento.listar_pagamentos'))

@rotas_pagamento.route('/editar-pagamento', methods=['GET', 'POST'])
def editar_pagamento():
    idpagamento = {"idpagamento": request.form["idpagamento"]}
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
    conn.update_data("pagamento", dados, idpagamento)
    return redirect(url_for('rotas_pagamento.listar_pagamentos'))



@rotas_pagamento.route('/apagar-pagamento', methods=['GET', 'POST'])
def apagar_pagamento():
    idpagamento = {"idpagamento": request.form["idpagamento"]}
    conn.delete_data("pagamento", idpagamento)
    return redirect(url_for('rotas_pagamento.listar_pagamentos'))



@rotas_pagamento.route('/pesquisar-pagamento', methods=['GET', 'POST'])
def pesquisar_pagamento():
    param = request.form["param"]
    # colls = request.form["colls"]
    dados =  conn.select_data(table="pagamento", search= param)

    print("dados") 
    if dados:
     return render_template('pesquisa.html', dados = dados)
    else:
     return render_template('pesquisa.html', dados = [{"response":"Não encontrado" }])







app.register_blueprint(rotas_pagamento)
if __name__ == '__main__':
    app.run(debug=True)