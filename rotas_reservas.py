from flask import Flask, render_template, request, redirect, url_for, Blueprint, jsonify

from programa.z_database_manager import DatabaseManager
conn = DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel", port=3306)
app = Flask(__name__, static_folder='assets', static_url_path='/assets')
rotas_reserva = Blueprint("rotas_reserva", __name__)
from programa.HP_functions import *



@rotas_reserva.route('/reservas')
def listar_reservas():
    dados = free_select('''

SELECT 

r.*,
c.*,
a.*,
m.*,
q.numQuarto,

CONCAT (c.primeiroNome, " ", c.nomeDoMeio, " ", c.ultimoNome) AS nomeCompleto


FROM reserva r

LEFT JOIN cliente c
ON r.idcliente = c.idcliente

LEFT JOIN agencia a
ON r.idagencia = a.idagencia


LEFT JOIN metodoreserva m
ON r.idmetodo = m.idmetodo

LEFT JOIN reservaquarto q 

ON r.idReserva = q.idReserva
''')
    clientes = free_select('''SELECT 

CONCAT("id: ", idcliente, " -| nome: ",  primeiroNome, ' ', nomeDoMeio, ' ', ultimoNome) as nomecliente,

idcliente


from cliente''') 
    action = "pesquisar-reserva"

    quartos = free_select("Select * from quarto")
    if dados is not None:
        return render_template('reservas.html', dados=dados, action = action, clientes = clientes, quartos = quartos)
    else:
    
        return render_template('reservas.html')
    


@rotas_reserva.route('/criar-reserva', methods=['GET', 'POST'])
def criar_reserva():
    dados = {

        "idCliente": request.form["idCliente"],
        "dataEntrada": request.form["dataEntrada"],
        "dataSaida": request.form["dataSaida"],
        "numAdultos": request.form["numAdultos"],
        "numCriancas": request.form["numCriancas"],
        "numBebes": request.form["numBebes"],
        "observacoes": request.form["observacoes"],
        "tipologiaContratada": request.form["tipologiaContratada"],
        "idAgencia": 1,
        "idMetodo": 1,
        "numQuarto": request.form["numQuarto"]
    
    }


    inserir_reserva = stored_procedure("InserirReserva", (dados["idCliente"], dados["dataEntrada"], dados["dataSaida"], dados["numAdultos"], dados["numCriancas"], dados["numBebes"], dados["observacoes"], dados["tipologiaContratada"], dados["idAgencia"], dados["idMetodo"], dados["numQuarto"]))
  
    status = dicionario({"status": inserir_reserva["status"]})

    print(status)
  
    return render_template('reserva_sucesso.html', status = status)




@rotas_reserva.route('/editar-reserva', methods=['GET', 'POST'])
def editar_reserva():
    idReserva = {"idReserva": request.form["idReserva"]}
    dados = {

        "idCliente": request.form["idCliente"],
        "dataEntrada": request.form["dataEntrada"],
        "dataSaida": request.form["dataSaida"],
        "numAdultos": request.form["numAdultos"],
        "numCriancas": request.form["numCriancas"],
        "numBebes": request.form["numBebes"],
        "observacoes": request.form["observacoes"],
        "tipologiaContratada": request.form["tipologiaContratada"],
        "idAgencia": 1,
        "idMetodo": 1,
    
    }

    conn.update_data("reserva", dados, idReserva)

    dados2 = {
            "numQuarto": request.form["numQuarto"], 
            "idReserva":request.form["idReserva"] ,
            "observacoes": request.form["observacoes"],
    }
    inserir("reservaquarto", dados2)
    return redirect(url_for('rotas_reserva.listar_reservas'))



@rotas_reserva.route('/apagar-reserva', methods=['GET', 'POST'])
def apagar_reserva():
    idReserva = {"idReserva": request.form["idReserva"]}
    conn.delete_data("reserva", idReserva)
    return redirect(url_for('rotas_reserva.listar_reservas'))



@rotas_reserva.route('/pesquisar-reserva', methods=['GET', 'POST'])
def pesquisar_reserva():
    param = request.form["param"]
    # colls = request.form["colls"]
    dados =  conn.select_data(table="reserva", search= param)

    print("dados") 
    if dados:
     return render_template('pesquisa.html', dados = dados)
    else:
     return render_template('pesquisa.html', dados = [{"response":"Não encontrado" }])


@rotas_reserva.route('/quartos-tipologia', methods=['POST'])
def get_quartos():
    tipologia = request.form['tipologia']

   
    sql_query = f"SELECT numQuarto, CONCAT('Quarto ', numQuarto) AS label FROM quarto WHERE tipologia = '{tipologia}' AND estaDisponivel = 1 AND ativo = 1"


    quartos_tipologia = free_select(sql_query)

    options = [{'numQuarto': str(quarto['numQuarto']), 'label': quarto['label']} for quarto in quartos_tipologia]

    # Retornar as opções em formato JSON
    return jsonify(options)


app.register_blueprint(rotas_reserva)
if __name__ == '__main__':
    app.run(debug=True)