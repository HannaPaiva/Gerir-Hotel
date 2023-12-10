from flask import Flask, render_template, request, redirect, url_for, Blueprint
from programa.HP_Cliente import *
from programa.z_database_manager import DatabaseManager

conn = DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel", port=3306)

app = Flask(__name__, static_folder='assets', static_url_path='/assets')
rotas_agencia = Blueprint("rotas_cliente", __name__)


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

@rotas_agencia.route('/editar-cliente', methods=['GET', 'POST'])
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

@rotas_agencia.route('/apagar-cliente', methods=['GET', 'POST'])
def apagar_cliente():
    idcliente = {"idcliente": request.form["idcliente"]}
    conn.delete_data("cliente", idcliente)
    return redirect(url_for('rotas_cliente.listar_clientes'))
 
@rotas_agencia.route('/pesquisar-cliente', methods=['GET', 'POST'])
def pesquisar_cliente():
    param = request.form["param"]
    # colls = request.form["colls"]
    res =  conn.select_data(table="cliente", search= param)
    print(res)
    
app.register_blueprint(rotas_agencia)

if __name__ == '__main__':
    app.run(debug=True)