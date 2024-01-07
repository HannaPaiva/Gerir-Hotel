from flask import Flask, render_template, request, redirect, url_for, Blueprint
from programa.z_database_manager import DatabaseManager
from programa.HP_functions import *
conn = DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel", port=3306)
app = Flask(__name__, static_folder='assets', static_url_path='/assets')
rotas_pagamento = Blueprint("rotas_pagamento", __name__)

@rotas_pagamento.route('/pagamentos')
def listar_pagamentos():
    dados = free_select("select * from pagamento")
    action = "pesquisar-pagamento"
    if dados is not None:
        return render_template('pagamentos.html', dados=dados, action=action)
    else:
        return render_template('pagamentos.html')

@rotas_pagamento.route('/criar-pagamento', methods=['GET', 'POST'])
def criar_pagamento():
    dados = {
        "valorTotal": request.form["valorTotal"],
        "metodoPagamento": request.form["metodoPagamento"],
        "tarifaReembolsavel": request.form["tarifaReembolsavel"],
        "dataPagamento": request.form["dataPagamento"],
        "observacoes": request.form["observacoes"],
        "status": request.form["status"],
        "idReserva": request.form["idReserva"]
    }
    conn.insert_data("pagamento", dados)
    return redirect(url_for('rotas_pagamento.listar_pagamentos'))

@rotas_pagamento.route('/editar-pagamento', methods=['GET', 'POST'])
def editar_pagamento():
    idPagamento = {"idPagamento": request.form["idPagamento"]}
    dados = {
        "valorTotal": request.form["valorTotal"],
        "metodoPagamento": request.form["metodoPagamento"],
        "tarifaReembolsavel": request.form["tarifaReembolsavel"],
        "dataPagamento": request.form["dataPagamento"],
        "observacoes": request.form["observacoes"],
        "status": request.form["status"],
        "idReserva": request.form["idReserva"]
    }
    conn.update_data("pagamento", dados, idPagamento)
    return redirect(url_for('rotas_pagamento.listar_pagamentos'))

@rotas_pagamento.route('/apagar-pagamento', methods=['GET', 'POST'])
def apagar_pagamento():
    idPagamento = {"idPagamento": request.form["idPagamento"]}
    conn.delete_data("pagamento", idPagamento)
    return redirect(url_for('rotas_pagamento.listar_pagamentos'))

@rotas_pagamento.route('/pesquisar-pagamento', methods=['GET', 'POST'])
def pesquisar_pagamento():
    param = request.form["param"]
    dados = conn.select_data(table="pagamento", search=param)

    if dados:
        return render_template('pesquisa_pagamento.html', dados=dados)
    else:
        return render_template('pesquisa_pagamento.html', dados=[{"response": "Não encontrado"}])

app.register_blueprint(rotas_pagamento)

if __name__ == '__main__':
    app.run(debug=True)
