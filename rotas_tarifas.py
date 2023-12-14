from flask import Flask, render_template, request, redirect, url_for, Blueprint
from programa.z_database_manager import DatabaseManager
conn = DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel", port=3306)
app = Flask(__name__, static_folder='assets', static_url_path='/assets')
rotas_tarifa = Blueprint("rotas_tarifa", __name__)


@rotas_tarifa.route('/tarifas')
def listar_tarifas():
    dados = conn.select_data("tarifa")
    action = "pesquisar-tarifa"
    if dados is not None:
        return render_template('tarifas.html', dados=dados, action = action)
    else:
        return render_template('tarifas.html')
    

    

@rotas_tarifa.route('/criar-tarifa', methods=['GET', 'POST'])
def criar_tarifa():
    dados = {
        "data": request.form["data"],
        "preconoiteadulto": request.form["preconoiteadulto"],
        "preonoitecrianca": request.form["preonoitecrianca"],
        "tipologia": request.form["tipologia"],
      
    }
    conn.insert_data("tarifa", dados)
    return redirect(url_for('rotas_tarifa.listar_tarifas'))

@rotas_tarifa.route('/editar-tarifa', methods=['GET', 'POST'])
def editar_tarifa():
    idtarifa = {"idtarifa": request.form["idtarifa"]}
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
    conn.update_data("tarifa", dados, idtarifa)
    return redirect(url_for('rotas_tarifa.listar_tarifas'))



@rotas_tarifa.route('/apagar-tarifa', methods=['GET', 'POST'])
def apagar_tarifa():
    idtarifa = {"idtarifa": request.form["idtarifa"]}
    conn.delete_data("tarifa", idtarifa)
    return redirect(url_for('rotas_tarifa.listar_tarifas'))



@rotas_tarifa.route('/pesquisar-tarifa', methods=['GET', 'POST'])
def pesquisar_tarifa():
    param = request.form["param"]
    # colls = request.form["colls"]
    dados =  conn.select_data(table="tarifa", search= param)

    if dados:
     return render_template('pesquisa.html', dados = dados)
    else:
     return render_template('pesquisa.html', dados = [{"response":"Não encontrado" }])







app.register_blueprint(rotas_tarifa)
if __name__ == '__main__':
    app.run(debug=True)