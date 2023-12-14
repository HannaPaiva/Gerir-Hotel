from flask import Flask, render_template, request, redirect, url_for, Blueprint
from programa.AS_preco import *
from programa.z_database_manager import DatabaseManager

conn = DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel", port=3306)

app = Flask(__name__, static_folder='assets', static_url_path='/assets')
rotas_preco = Blueprint("rotas_preco", __name__)


@rotas_preco.route('/preco')
def listar_precos():
    dados = conn.select_data("preco")
    if dados is not None:
        return render_template('precos.html', dados=dados)
    else:
        return render_template('precos.html')

@rotas_preco.route('/criar-preco', methods=['GET', 'POST'])
def criar_preco():
    dados = {
        "idpreco": request.form["idpreco"],
        "nomepreco": request.form["nomepreco"],
        "contatogeral": request.form["contatogeral"],
        "nomerepresentante": request.form["nomerepresentante"],
        "telefonerepresentante": request.form["telefonerepresentante"],
        "comissaopreco": request.form["comissaopreco"],
    }
    conn.insert_data("preco", dados)
    return redirect(url_for('rotas_preco.listar_precos'))

@rotas_preco.route('/editar-preco', methods=['GET', 'POST'])
def editar_preco():
    idpreco = {"idpreco": request.form["idpreco"]}
    dados = {
        "id_tarifa": request.form["id_tarifa"],
        "id_reserva": request.form["id_reserva"],
        "preco_manual": request.form["preco_manual"],
    }
    conn.insert_data("preco", dados)
    return redirect(url_for('rotas_preco.listar_precos'))

@rotas_preco.route('/apagar-preco', methods=['GET', 'POST'])
def apagar_preco():
    id_tarifa = {"id_tarifa": request.form["id_tarifa"]}
    conn.delete_data("preco", id_tarifa)
    return redirect(url_for('rotas_preco.listar_id_tarifa'))
 
@rotas_preco.route('/pesquisar-preco', methods=['GET', 'POST'])
def pesquisar_preco():
    param = request.form["param"]
    # colls = request.form["colls"]
    res =  conn.select_data(table="preco", search= param)
    print(res)
    
app.register_blueprint(rotas_preco)

if __name__ == '__main__':
    app.run(debug=True)