from flask import Flask, render_template, request, redirect, url_for, Blueprint
from programa.z_database_manager import DatabaseManager
conn = DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel", port=3306)
app = Flask(__name__, static_folder='assets', static_url_path='/assets')
rotas_agencia = Blueprint("rotas_agencia", __name__)



@rotas_agencia.route('/agencias')
def listar_agencias():
    dados = conn.select_data("agencia")
    action = "pesquisar-agencia"
    if dados is not None:
        return render_template('agencias.html', dados=dados, action = action)
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
    conn.insert_data("agencia", dados)
    return redirect(url_for('rotas_agencia.listar_agencias'))

@rotas_agencia.route('/editar-agencia', methods=['GET', 'POST'])
def editar_agencia():
    idagencia = {"idagencia": request.form["idagencia"]}
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
    conn.update_data("agencia", dados, idagencia)
    return redirect(url_for('rotas_agencia.listar_agencias'))



@rotas_agencia.route('/apagar-agencia', methods=['GET', 'POST'])
def apagar_agencia():
    idagencia = {"idagencia": request.form["idagencia"]}
    conn.delete_data("agencia", idagencia)
    return redirect(url_for('rotas_agencia.listar_agencias'))



@rotas_agencia.route('/pesquisar-agencia', methods=['GET', 'POST'])
def pesquisar_agencia():
    param = request.form["param"]
    # colls = request.form["colls"]
    dados =  conn.select_data(table="agencia", search= param)

    print("dados") 
    if dados:
     return render_template('pesquisa.html', dados = dados)
    else:
     return render_template('pesquisa.html', dados = [{"response":"Não encontrado" }])







app.register_blueprint(rotas_agencia)
if __name__ == '__main__':
    app.run(debug=True)