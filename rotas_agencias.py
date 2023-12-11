from flask import Flask, render_template, request, redirect, url_for, Blueprint
from programa.AS_agencia import *
from programa.z_database_manager import DatabaseManager

conn = DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel", port=3306)

app = Flask(__name__, static_folder='assets', static_url_path='/assets')
rotas_agencia = Blueprint("rotas_agencia", __name__)


@rotas_agencia.route('/agencias')
def listar_agencias():
    dados = conn.select_data("agencia")
    if dados is not None:
        return render_template('agencias.html', dados=dados)
    else:
        return render_template('agencias.html')

@rotas_agencia.route('/criar-agencia', methods=['GET', 'POST'])
def criar_agencia():
    dados = {
        "idagencia": request.form["idagencia"],
        "nomeagencia": request.form["nomeagencia"],
        "contatogeral": request.form["contatogeral"],
        "nomerepresentante": request.form["nomerepresentante"],
        "telefonerepresentante": request.form["telefonerepresentante"],
        "comissaoagencia": request.form["comissaoagencia"],
    }
    conn.insert_data("agencia", dados)
    return redirect(url_for('rotas_agencia.listar_agencias'))

@rotas_agencia.route('/editar-agencia', methods=['GET', 'POST'])
def editar_agencia():
    idagencia = {"idagencia": request.form["idagencia"]}
    dados = {
        "idagencia": request.form["idagencia"],
        "nomeagencia": request.form["nomeagencia"],
        "contatogeral": request.form["contatogeral"],
        "nomerepresentante": request.form["nomerepresentante"],
        "telefonerepresentante": request.form["telefonerepresentante"],
        "comissaoagencia": request.form["comissaoagencia"],
    }
    conn.insert_data("agencia", dados)
    return redirect(url_for('rotas_agencia.listar_agencias'))

@rotas_agencia.route('/apagar-agencia', methods=['GET', 'POST'])
def apagar_agencia():
    idagencia = {"idagencia": request.form["idcagencia"]}
    conn.delete_data("agencia", idagencia)
    return redirect(url_for('rotas_agencia.listar_agencia'))
 
@rotas_agencia.route('/pesquisar-agencia', methods=['GET', 'POST'])
def pesquisar_agencia():
    param = request.form["param"]
    # colls = request.form["colls"]
    res =  conn.select_data(table="agencia", search= param)
    print(res)
    
app.register_blueprint(rotas_agencia)

if __name__ == '__main__':
    app.run(debug=True)