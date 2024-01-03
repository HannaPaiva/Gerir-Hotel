from flask import Flask, render_template, request, redirect, url_for, Blueprint
from programa.z_database_manager import DatabaseManager
from programa.HP_functions import *
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
   
    data_inicio = request.form["data_inicio"]
    data_fim = request.form["data_fim"]
    preconoiteadulto = request.form["preconoiteadulto"]
    preconoitecrianca = request.form["preconoitecrianca"]
    numQuarto = request.form["numQuarto"]
      
    

    chamar_procedimento(data_inicio, data_fim, preconoiteadulto, preconoitecrianca, numQuarto)
   
    return redirect(url_for('rotas_tarifa.listar_tarifas'))



@rotas_tarifa.route('/apagar-tarifa', methods=['GET', 'POST'])
def apagar_tarifa():
    de =  request.form["de"]
    ate =  request.form["ate"]
    numQuarto =  request.form["numQuarto"]
   
    apagar_tarifas(de, ate, numQuarto)

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