from flask import Flask, render_template, request, redirect, url_for, Blueprint
from programa.z_database_manager import DatabaseManager
conn = DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel", port=3306)
app = Flask(__name__, static_folder='assets', static_url_path='/assets')
rotas_reserva = Blueprint("rotas_reserva", __name__)


@rotas_reserva.route('/reservas')
def listar_reservas():
    dados = conn.select_data("reserva")
    action = "pesquisar-reserva"
    if dados is not None:
        return render_template('reservas.html', dados=dados, action = action)
    else:
        return render_template('reservas.html')
    

    

@rotas_reserva.route('/criar-reserva', methods=['GET', 'POST'])
def criar_reserva():
    dados = {
        "idcliente": request.form["idcliente"],
        "dataentrada": request.form["dataentrada"],
        "datasaida": request.form["datasaida"],
        "numadultos": request.form["numadultos"],
        "numcriancas": request.form["numcriancas"],
        "numbebes": request.form["numbebes"],
        "observacoes": request.form["observacoes"],
        "tipologiacontratada": request.form["tipologiacontratada"],
        "Agencia_has_MetodoReserva_Agencia_idAgencia": request.form["Agencia_has_MetodoReserva_Agencia_idAgencia"],
        "Agencia_has_MetodoReserva_MetodoReserva_idMetodo": request.form["Agencia_has_MetodoReserva_MetodoReserva_idMetodo"],
    }
    conn.insert_data("reserva", dados)
    return redirect(url_for('rotas_reserva.listar_reservas'))

@rotas_reserva.route('/editar-reserva', methods=['GET', 'POST'])
def editar_reserva():
    idreserva = {"idreserva": request.form["idreserva"]}
    dados = {
        "idcliente": request.form["idcliente"],
        "dataentrada": request.form["dataentrada"],
        "datasaida": request.form["datasaida"],
        "numadultos": request.form["numadultos"],
        "numcriancas": request.form["numcriancas"],
        "numbebes": request.form["numbebes"],
        "observacoes": request.form["observacoes"],
        "tipologiacontratada": request.form["tipologiacontratada"],
        "Agencia_has_MetodoReserva_Agencia_idAgencia": request.form["Agencia_has_MetodoReserva_Agencia_idAgencia"],
        "Agencia_has_MetodoReserva_MetodoReserva_idMetodo": request.form["Agencia_has_MetodoReserva_MetodoReserva_idMetodo"],
        
    }
    conn.update_data("reserva", dados, idreserva)
    return redirect(url_for('rotas_reserva.listar_reservas'))



@rotas_reserva.route('/apagar-reserva', methods=['GET', 'POST'])
def apagar_reserva():
    idreserva = {"idreserva": request.form["idreserva"]}
    conn.delete_data("reserva", idreserva)
    return redirect(url_for('rotas_reserva.listar_reservas'))



@rotas_reserva.route('/pesquisar-reserva', methods=['GET', 'POST'])
def pesquisar_reserva():
    param = request.form["param"]
    # colls = request.form["colls"]
    dados =  conn.select_data(table="reserva", search= param)

    return render_template('pesquisa.html', dados = dados)







app.register_blueprint(rotas_reserva)
if __name__ == '__main__':
    app.run(debug=True)